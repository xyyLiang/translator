    func releaseConnection():Unit{
        synchronized(m){
            if(let Some(i) <- connection){
                i.release()
            }
            connection = Option<DownloadConnection>.None
        }
    }