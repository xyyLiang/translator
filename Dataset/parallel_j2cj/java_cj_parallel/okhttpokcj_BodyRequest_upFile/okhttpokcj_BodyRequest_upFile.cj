    public func upFile(file: FileInfo): Request {
        this.file = file
        var filePath: String = file.getCanonicalPath()
        let con: Option<Int64> = filePath.lastIndexOf("/")
        var lastSlash: Int64 = 0
        match (con) {
           case Some(v) => lastSlash = v
           case None => ()
        }
        let fileName: String = filePath.substring(lastSlash + 1)
        this.mediaType = HttpUtils.guessMimeType(fileName)
        return this
    }