     func getFile():Option<File>{
        let filenames:Option<String> = filenameHolder.get()
        if(let Some(_) <- filenames){
        }else{
            return Option<File>.None
        }

        if(let Some(_) <- targetFile){
        }else{
            targetFile = File(directoryFile.info.path.toString()+filenames.getOrThrow(),OpenOption.Open(true,true)); //targetFile就是下载的目标文件
        }
        return targetFile
    }