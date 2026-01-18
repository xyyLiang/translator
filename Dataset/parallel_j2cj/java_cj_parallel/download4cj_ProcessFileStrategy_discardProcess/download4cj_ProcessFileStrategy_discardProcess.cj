     func discardProcess(task:DownloadTask):Unit{
        let file:Option<File> = task.getFile()
        if(let Some(_) <- file){
        }else{
            return
        }

        if(File.exists(file.getOrThrow().info.path)){
            try{
                if(!file.getOrThrow().isClosed()){
                    file.getOrThrow().close()
                }
                File.delete(file.getOrThrow().info.path)
            }catch(e:Exception){
                throw ReadWriteException("Delete file failed!")
            }
        }
    }