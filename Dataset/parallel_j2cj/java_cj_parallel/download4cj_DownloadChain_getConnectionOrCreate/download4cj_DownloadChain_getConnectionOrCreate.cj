    func getConnectionOrCreate():DownloadConnection{
        synchronized(m){

            if (cache.isInterrupt()){
                throw InterruptException.SIGNAL
            }
            if(let Some(_) <- connection){
            }else{
                var url:String = ""
                let redirectLocation:Option<String> = cache.getRedirectLocation()
                if(let Some(j) <- redirectLocation){
                    if(Util.isEmpty(j)){
                        url = info.getUrl()
                    }else{
                        url = j
                    }
                }else{
                    url = info.getUrl()
                }
                Util.d(TAG, "create connection on url: " + url)
                connection = Download4cj.withs().connectionFactory().create(url)
            }
             return connection.getOrThrow()
        }
    }