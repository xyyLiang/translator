    private func getContentLength(pHeaders: FileItemHeaders): Int64 {
        try {
            let contentLength: String = pHeaders.getHeader(CONTENT_LENGTH).getOrThrow()
            let len: Int64 = Int64.parse(contentLength)
            return len
        } catch (e: Exception) {
            return -1
        }
    }