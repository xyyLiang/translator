    public func interceptFetch(chain:DownloadChain):Int64{
        if (chain.getCache().isInterrupt()){
            throw InterruptException.SIGNAL
        }

        // fetch

        var stream = ByteArrayStream()

        var fetchLength:Int64 = source.read(stream,task.getReadBufferSize())

        if(fetchLength <= 0){
            return fetchLength
        }

        // write to file
        outputStream.write(blockIndex, stream.readToEnd())


        chain.increaseCallbackBytes(fetchLength)

        if (this.dispatcher.isFetchProcessMoment(task)) {
            chain.flushNoCallbackIncreaseBytes()
        }

        return fetchLength

    }