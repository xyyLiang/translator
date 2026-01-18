    func processConnect():DownloadConnectionConnected{

        if (cache.isInterrupt()){
            throw InterruptException.SIGNAL
        }

        let connect : InterceptorConnect = connectInterceptorList.get(connectIndex).getOrThrow()
        connectIndex++
        return connect.interceptConnect(this).getOrThrow()

    }