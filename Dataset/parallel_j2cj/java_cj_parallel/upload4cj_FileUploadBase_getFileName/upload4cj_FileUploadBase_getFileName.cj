    protected func getFileName(headers: FileItemHeaders): Option<String> {
        return getFileName(headers.getHeader(CONTENT_DISPOSITION))
    }