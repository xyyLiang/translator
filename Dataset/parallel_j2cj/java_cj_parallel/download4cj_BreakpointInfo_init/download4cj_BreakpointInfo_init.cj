    init(id:Int64,url:String,parentFile:Option<Directory>,filename:String){
        this.id = id
        this.url = url
        this.parentFile = parentFile
        this.blockInfoList = ArrayList<BlockInfo>()
        this.targetFile = Option<File>.None
        if(filename.isEmpty()){
             filenameHolder = FileNameHolder()
             taskOnlyProvidedParentPath = true
        }else{
            filenameHolder = FileNameHolder(filename)
            taskOnlyProvidedParentPath = false
            let filePath:Path = parentFile.getOrThrow().info.path.join(filename)
            this.targetFile = File.openRead(filePath)
        }
        etag = ""
    }