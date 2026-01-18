    public func getItemIterator(ctx: RequestContext): FileItemIterator {
        try {
            return FileItemIteratorImpl(ctx, this)
        } catch (e: FileUploadException) {
            throw FileUploadException("FileItem Get Fail")
        }
    }