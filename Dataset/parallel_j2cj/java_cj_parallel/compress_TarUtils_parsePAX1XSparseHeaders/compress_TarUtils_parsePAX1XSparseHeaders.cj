    @OverflowWrapping
    public static func parsePAX1XSparseHeaders(inputStream: InputStream, recordSize: Int64): ArrayList<TarArchiveStructSparse> {
        // for 1.X PAX Headers
        let sparseHeaders: ArrayList<TarArchiveStructSparse> = ArrayList<TarArchiveStructSparse>()
        var bytesRead: Int64 = 0
        var readResult: Array<Int64> = readLineOfNumberForPax1X(inputStream)
        var sparseHeadersCount: Int64 = readResult[0]
        if (sparseHeadersCount < 0) {
            throw Exception("Corrupted TAR archive. Negative value in sparse headers block")
        }
        bytesRead += readResult[1]
        while (sparseHeadersCount > 0) {
            sparseHeadersCount--
            readResult = readLineOfNumberForPax1X(inputStream)
            let sparseOffset: Int64 = readResult[0]
            if (sparseOffset < 0) {
                throw Exception("Corrupted TAR archive. Sparse header block offset contains negative value")
            }
            bytesRead += readResult[1]

            readResult = readLineOfNumberForPax1X(inputStream)
            let sparseNumbytes: Int64 = readResult[0]
            if (sparseNumbytes < 0) {
                throw Exception("Corrupted TAR archive. Sparse header block numbytes contains negative value")
            }
            bytesRead += readResult[1]
            sparseHeaders.append(TarArchiveStructSparse(sparseOffset, sparseNumbytes))
        }
        sparseHeadersCount--
        // skip the rest of this record data
        let bytesToSkip = recordSize - bytesRead % recordSize
        skip(inputStream, bytesToSkip)
        return sparseHeaders
    }