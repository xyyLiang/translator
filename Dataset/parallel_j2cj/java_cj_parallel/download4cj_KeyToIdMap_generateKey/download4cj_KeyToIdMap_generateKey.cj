    func generateKey(task:DownloadTask):String{
        if(Util.isEmpty(task.getFilename())){
            return task.getUrl()+task.getUri().toString()
        }else{
            return task.getUrl()+task.getUri().toString()+task.getFilename().getOrThrow()
        }
    }