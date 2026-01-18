    public open func onResponseError (requestStats: RequestStats, e: Exception): Unit {
        match (mOnStatusCodeAwareResponseListener){
            case Some(x) =>  x.onResponseNetworkError(requestStats,e)
            case None => ()
        }
    }