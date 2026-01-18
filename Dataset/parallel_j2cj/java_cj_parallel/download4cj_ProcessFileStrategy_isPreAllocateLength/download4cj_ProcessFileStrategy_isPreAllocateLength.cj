     func isPreAllocateLength(task:DownloadTask):Bool{
        var supportSeek:Bool = Download4cj.withs().outputStreamFactory().supportSeek()
        if(!supportSeek){
            return false
        }
        if(let Some(i) <- task.getSetPreAllocateLength()){
            return i
        }else{
            return true
        }
    }