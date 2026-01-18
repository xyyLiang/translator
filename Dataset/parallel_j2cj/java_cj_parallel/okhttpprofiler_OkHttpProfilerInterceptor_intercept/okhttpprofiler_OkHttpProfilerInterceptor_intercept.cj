    public func intercept(chain: Chain): Response {
        let id = generateId()
        let nowSjc = Time.now().unixNano()
        let startTime = nowSjc / 1000 / 1000
        dataTransfer.sendRequest(id,chain.getRequest())
        try{
            var response = chain.proceed(chain.getRequest())
            dataTransfer.sendResponse(id,response)
            let nowSjc2 = Time.now().unixNano()
            let startTime2 = nowSjc2 / 1000 / 1000
            dataTransfer.sendDuration(id,startTime2 - startTime)
            return response
        }catch(e : Exception){
            dataTransfer.sendException(id, e);
            let nowSjc3 = Time.now().unixNano()
            let startTime3 = nowSjc3 / 1000 / 1000
            dataTransfer.sendDuration(id, startTime3 - startTime);
            throw e;
        }
    }