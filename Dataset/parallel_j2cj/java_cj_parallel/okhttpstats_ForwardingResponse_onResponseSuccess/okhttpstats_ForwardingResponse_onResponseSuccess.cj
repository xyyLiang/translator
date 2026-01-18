    public open func onResponseSuccess (requestStats: RequestStats): Unit {
        var statusCode: Int64 = requestStats.statusCode
        if ((statusCode >= HttpStatusCode.HTTP_2XX_START && statusCode <= HttpStatusCode.HTTP_2XX_END) ||
                (statusCode >= HttpStatusCode.HTTP_3XX_START && statusCode <= HttpStatusCode.HTTP_3XX_END)) {
            match (mOnStatusCodeAwareResponseListener){
                case Some(x) =>  x.onResponseServerSuccess(requestStats)
                case None => ()
            }
        } else if ((statusCode >= HttpStatusCode.HTTP_4XX_START && statusCode <= HttpStatusCode.HTTP_4XX_END) ||
                (statusCode >= HttpStatusCode.HTTP_5XX_START && statusCode <= HttpStatusCode.HTTP_5XX_END)) {
            match (mOnStatusCodeAwareResponseListener){
                case Some(x) =>  x.onResponseServerError(requestStats)
                case None => ()
            }
        }
    }