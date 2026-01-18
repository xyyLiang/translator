    public func interceptConnect(chain:DownloadChain):Option<DownloadConnectionConnected>{

        let cache:DownloadCache =  chain.getCache()
        while(true){
            try{
                if(cache.isInterrupt()){
                    throw InterruptException.SIGNAL
                }
                return chain.processConnect()
            }catch (e:IOException) {
                throw e
            }
        }
        return Option<DownloadConnectionConnected>.None
    }