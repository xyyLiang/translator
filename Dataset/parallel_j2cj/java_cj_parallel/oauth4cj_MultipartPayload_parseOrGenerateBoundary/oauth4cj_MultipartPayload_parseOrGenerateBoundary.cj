    private static func parseOrGenerateBoundary(headers: HashMap<String, String>): String {
        let parsedBoundary: String = MultipartUtils.parseBoundaryFromHeader(headers.get(OAuthConstants.CONTENT_TYPE) ?? "")
        if (parsedBoundary.isEmpty()) {
            return MultipartUtils.generateDefaultBoundary()
        }
        return parsedBoundary
    }