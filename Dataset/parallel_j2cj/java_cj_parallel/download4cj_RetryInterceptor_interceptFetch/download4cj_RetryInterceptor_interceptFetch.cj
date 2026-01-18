    public func interceptFetch(chain:DownloadChain):Int64{
        try {
            return chain.processFetch()
        } catch (e:IOException) {
            throw e
        }
    }