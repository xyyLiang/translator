    private func readSparse(buf: Array<Byte>, offset: Int64, numToRead: Int64): Int64 {
        if (this.sparseInputStreams.size == 0) {
            return this.inputStream.read(buf[offset..offset+numToRead])
        }
        if (this.currentSparseInputStreamIndex >= this.sparseInputStreams.size) {
            return -1
        }
        let currentInputStream: InputStream = this.sparseInputStreams[this.currentSparseInputStreamIndex]
        let readLen: Int64 = currentInputStream.read(buf[offset..offset+numToRead])
        if (this.currentSparseInputStreamIndex == this.sparseInputStreams.size - 1) {
            return readLen
        }
        if (readLen == -1) {
            this.currentSparseInputStreamIndex++
            return this.readSparse(buf, offset, numToRead)
        }
        if (readLen < numToRead) {
            this.currentSparseInputStreamIndex++
            let readLenOfNext: Int64 = this.readSparse(buf, offset + readLen, numToRead - readLen)
            if (readLenOfNext == -1) {
                return readLen
            }
            return readLen + readLenOfNext
        }
        return readLen
    }