    public func interceptConnect(chain:DownloadChain):Option<DownloadConnectionConnected>{
         return chain.getConnectionOrCreate().execute()
    }