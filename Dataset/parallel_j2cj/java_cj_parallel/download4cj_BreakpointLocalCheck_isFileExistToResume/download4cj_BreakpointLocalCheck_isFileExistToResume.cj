    func isFileExistToResume():Bool{
        let file:Option<File> = task.getFile()
        if(let Some(_) <- file){
        }else{
            return false
        }
        if(File.exists(file.getOrThrow().info.path)){
            return true
        }else{
            return false
        }
    }