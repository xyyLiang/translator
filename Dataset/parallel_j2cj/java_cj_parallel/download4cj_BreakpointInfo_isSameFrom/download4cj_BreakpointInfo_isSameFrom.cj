    func isSameFrom(task:DownloadTask):Bool{
        if(!parentFile.getOrThrow().info.path.toString().equals(task.getParentFile().info.path.toString())){
            return false
        }
        if(!url.equals(task.getUrl())){
            return false
        }
        let otherFilename:Option<String> = task.getFilename()
        if(let Some(i) <- otherFilename){
            if(i.equals(filenameHolder.get().getOrThrow())){
                return true
            }
        }
        return false
    }