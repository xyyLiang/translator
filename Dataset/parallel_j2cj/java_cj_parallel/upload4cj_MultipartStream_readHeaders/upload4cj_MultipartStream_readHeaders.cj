    public func readHeaders(): String {
        var i: Int64 = 0
        var b: UInt8

        // to support multi-byte characters
        var baos = ByteArrayStream()
        var size: Int64 = 0
        let arrayUint = ArrayList<UInt8>()
        while (i < HEADER_SEPARATOR.size) {
            try {
                b = readByte()
            } catch (e: FileUploadException) {
                throw FileUploadException("Headers Get Fail")
            } catch (e: ReadWriteException) {
                throw MalformedStreamException("Stream ended unexpectedly")
            }
            size++
            if (size > HEADER_PART_SIZE_MAX) {
                throw MalformedStreamException(
                    "Header section has more than %s bytes (maybe it is not properly terminated)")
            }
            if (b == HEADER_SEPARATOR[i]) {
                i++
            } else {
                i = 0
            }
            arrayUint.append(b)
        }
        baos.write(arrayUint.toArray())


        let isHeaderEncoding = match (headerEncoding) {
            case Some(_) => true
            case None => false
        }

        if (isHeaderEncoding) {
            try {
                // bytes -> String
                  unsafe{
                    return String.fromUtf8Unchecked(baos.readToEnd())
                  }
            } catch (e: ReadWriteException) {
                // Fall back to platform default if specified encoding is not
                // supported.
                unsafe{
                    return String.fromUtf8Unchecked(baos.readToEnd())
                  }            }
        } else {
                unsafe{
                    return String.fromUtf8Unchecked(baos.readToEnd())
                  }
        }
    }