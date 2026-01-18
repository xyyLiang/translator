    func loopFetch():Int64{
        if (fetchIndex == fetchInterceptorList.size) {
            // last one is fetch data interceptor
            fetchIndex--
        }
        return processFetch()
    }