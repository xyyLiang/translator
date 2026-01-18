    protected func getFieldName(headers: FileItemHeaders): Option<String> {
        return getFieldName(headers.getHeader(CONTENT_DISPOSITION))
    }