    public func readBoundary(): Bool {
        //var BoundaryMarker: Array<UInt8> = Array<UInt8>(2, item: 0)
        var BoundaryMarker1:UInt8 = 0
        var BoundaryMarker2:UInt8 = 0
        var nextChunk: Bool = false

        head = head + boundaryLength
        try {
            BoundaryMarker1 = readByte()
            if (BoundaryMarker1 == LF) {
                return true
            }
            BoundaryMarker2 = readByte()
            if (arrayequals(BoundaryMarker1,BoundaryMarker2, STREAM_TERMINATOR)) {
                nextChunk = false
            } else if (arrayequals(BoundaryMarker1,BoundaryMarker2, FIELD_SEPARATOR)) {
                nextChunk = true
            } else {
                throw MalformedStreamException("Unexpected characters follow a boundary")
            }
        } catch (e: FileUploadException) {
            // wraps a SizeException, re-throw as it will be unwrapped later
            throw e
        } catch (e: ReadWriteException) {
            throw MalformedStreamException("Stream ended unexpectedly")
        }
        return nextChunk
    }