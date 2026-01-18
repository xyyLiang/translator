    @OverflowWrapping
    public static func parsePaxHeaders(inputStream: InputStream,
                                  sparseHeaders: ?ArrayList<TarArchiveStructSparse>, 
                                  globalPaxHeaders: Map<String, String>,
                                  headerSize: Int64): Map<String, String> {
        let headers = HashMap<String, String>(globalPaxHeaders)
        var offset: ?Int64 = None
        var totalRead: Int64 = 0
        let arr = Array<Byte>(1, item: 0)
        while (true) {
            var ch: ?UInt8 = None
            var len: Int64 = 0
            var read: Int64 = 0
            while(inputStream.read(arr) != 0) {
                ch = arr[0]
                read++
                totalRead++
                if (ch.getOrThrow() == '\n') { // blank line in header
                    break
                }
                if (ch.getOrThrow() == ' '){ // End of length string
                    // Get keyword
                    let coll = ByteArrayStream()
                    while(inputStream.read(arr) != 0) {
                        ch = arr[0]
                        read++
                        totalRead++
                        if (totalRead < 0 || (headerSize >= 0 && totalRead >= headerSize)) {
                            break
                        }
                        if (ch.getOrThrow() == '='){ // end of keyword
                            let keyword = unsafe{String.fromUtf8Unchecked(coll.bytes())}
                            // Get rest of entry
                            let restLen = len - read
                            if (restLen <= 1) { // only NL
                                headers.remove(keyword)
                            } else if (headerSize >= 0 && restLen > headerSize - totalRead) {
                                throw TarIOException("Paxheader value size ${restLen} exceeds size of header record")
                            } else {
                                let rest = ReadRange(inputStream, restLen)
                                let got = rest.size
                                if (got != restLen) {
                                    throw TarIOException("Failed to read Paxheader. Expected ${restLen}  bytes, read ${got}")
                                }
                                totalRead += restLen
                                // Drop trailing NL
                                if (rest[restLen - 1] != '\n') {
                                    throw Exception("Failed to read Paxheader. Value should end with a newline")
                                }
                                let value =  unsafe{String.fromUtf8Unchecked(rest[0..restLen - 1])}
                                headers.put(keyword, value)

                                // for 0.0 PAX Headers
                                if (keyword == ("GNU.sparse.offset")) {
                                    match (offset) {
                                        case Some(v) => 
                                        // previous GNU.sparse.offset header but no numBytes
                                        sparseHeaders.getOrThrow().append(TarArchiveStructSparse(v, 0))

                                        case None => ()
                                    }
                                    try {
                                        offset = Int64.parse(value)
                                    } catch (ex: Exception) {
                                        throw Exception("Failed to read Paxheader.GNU.sparse.offset contains a non-numeric value")
                                    }
                                    if (offset.getOrThrow() < 0) {
                                        throw Exception("Failed to read Paxheader.GNU.sparse.offset contains negative value")
                                    }
                                }

                                // for 0.0 PAX Headers
                                if (keyword == ("GNU.sparse.numbytes")) {
                                    match (offset) {
                                        case Some(_) => ()
                                        case None => 
                                        throw Exception("Failed to read Paxheader.GNU.sparse.offset is expected before GNU.sparse.numbytes shows up.")
                                    }
                                    var numbytes = 0
                                    try {
                                        numbytes = Int64.parse(value)
                                    } catch (ex: Exception ) {
                                        throw Exception("Failed to read Paxheader.GNU.sparse.numbytes contains a non-numeric value.")
                                    }
                                    if (numbytes < 0) {
                                        throw Exception("Failed to read Paxheader.GNU.sparse.numbytes contains negative value")
                                    }
                                    sparseHeaders.getOrThrow().append(TarArchiveStructSparse(offset.getOrThrow(), numbytes))
                                    offset = None
                                }
                            }
                            break
                        }
                        coll.write(ch.getOrThrow())
                    }
                    ch = arr[0]
                    break // Processed single header
                }
                // COMPRESS-530 : throw if we encounter a non-number while reading length
                if (ch.getOrThrow() < '0' || ch.getOrThrow() > '9') {
                    throw TarIOException("Failed to read Paxheader. Encountered a non-number while reading length")
                }

                len *= 10
                len += Int64(ch.getOrThrow() - '0')
            }
            if (ch == None){ // EOF
                break
            }
        }
        match (offset) {
            case None => ()
            case Some(v) => sparseHeaders.getOrThrow().append(TarArchiveStructSparse(v, 0))
        }
        return headers
    }  