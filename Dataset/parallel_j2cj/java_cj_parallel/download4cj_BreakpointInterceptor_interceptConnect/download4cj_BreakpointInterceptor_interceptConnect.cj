    public func interceptConnect(chain:DownloadChain):Option<DownloadConnectionConnected>{
        let connected:DownloadConnectionConnected =  chain.processConnect()
        let info:BreakpointInfo = chain.getInfo()
        if(chain.getCache().isInterrupt()){
            throw InterruptException.SIGNAL
        }
        if(info.getBlockCount() == 1 && !info.isChunked()){
            let blockInstanceLength:Int64 = getExactContentLengthRangeFrom0(connected)
            let infoInstanceLength:Int64 =  info.getTotalLength()
            if(blockInstanceLength > 0 && blockInstanceLength != infoInstanceLength) {
                Download4cj.withs().callbackDispatcher().dispatch().downloadFromBeginning(chain.getTask())
            }
        }
        let store:DownloadStore = chain.getDownloadStore()
        try {
            if (!store.update(info)) {
                throw ReadWriteException("Update store failed!")
            }
        } catch (e:Exception) {
            throw ReadWriteException("Update store failed!"+e.toString())
        }
        return connected
    }