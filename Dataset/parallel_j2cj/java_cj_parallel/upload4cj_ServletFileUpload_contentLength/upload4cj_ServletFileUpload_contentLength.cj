    public override func contentLength(): Int64 {
        var size: Int64
        try {
            let contentLength: String = request.headers.get(FileUploadBase.CONTENT_LENGTH).iterator().next().getOrThrow()
            size = Int64.parse(contentLength)
        } catch (e: Exception) {
            size = request.bodySize.getOrThrow()
        }
        return size
    }