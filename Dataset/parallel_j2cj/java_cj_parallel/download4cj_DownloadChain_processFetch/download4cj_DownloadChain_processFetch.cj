    func processFetch():Int64{
        if (cache.isInterrupt()){
           throw InterruptException.SIGNAL
        }

        let fetch : InterceptorFetch = fetchInterceptorList.get(fetchIndex).getOrThrow()
        fetchIndex++
        return fetch.interceptFetch(this)
    }