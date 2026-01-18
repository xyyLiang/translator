    protected static func convertContentTypeToHeaders(contentType: String): HashMap<String, String> {
        if (contentType.isEmpty()) {
            return HashMap<String, String>()
        }
        return HashMap<String, String>([(OAuthConstants.CONTENT_TYPE, contentType)])
    }