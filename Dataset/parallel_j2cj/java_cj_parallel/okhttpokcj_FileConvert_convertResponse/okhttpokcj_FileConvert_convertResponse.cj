    public func convertResponse(response: okhttp.Response): File {
        let url: String = response.getRequest().getUrl().toString()
        var directoryInfo: DirectoryInfo = DirectoryInfo(folder)
        directoryInfo.create()
        var fileInfo: FileInfo = FileInfo(folder + "/" + fileName)
        fileInfo.delete()
        var file: File = File(fileInfo,ReadWrite,Open)
        var byteArrayStream: ByteArrayStream = ByteArrayStream()
        let bytes = Array<Byte>(8192, item: 0)
        try {
            var body: okhttp.ResponseBody = response.getBody().getOrThrow()
            byteArrayStream = body.getSource()
            var progress: Progress = Progress()
            progress.totalSize = body.getContentLength()
            progress.fileName = fileName
            progress.filePath = fileInfo.getCanonicalPath()
            progress.status = Progress.LOADING
            progress.url = url
            progress.tag = url
            var len: Int64 = 0
            while (true) {
                len = byteArrayStream.read(bytes)
                if(len == -1) {
                    break
                }
                file.write(bytes)
                Progress.changeProgress(progress, len, Action())
            }
            file.flush()
            return file
        } finally {
            file.close()
        }
    }