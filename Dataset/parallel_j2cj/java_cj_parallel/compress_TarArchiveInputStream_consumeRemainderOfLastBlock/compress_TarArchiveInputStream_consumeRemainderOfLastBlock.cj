    private func consumeRemainderOfLastBlock(): Unit {
        let bytesReadOfLastBlock: Int64 = getBytesRead() % blockSize
        if (bytesReadOfLastBlock > 0) {
            let skipped: Int64 = skip(inputStream, blockSize - bytesReadOfLastBlock)
            this.count(skipped)
        }
    }