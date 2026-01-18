    public func retry(retryCount: Int64): Request {

        if (retryCount < 0) {
            throw IllegalArgumentException("retryCount must > 0")
        }
        this.retryCount = retryCount
        return this
    }