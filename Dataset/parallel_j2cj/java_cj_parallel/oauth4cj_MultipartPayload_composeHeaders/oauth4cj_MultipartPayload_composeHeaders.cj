    private static func composeHeaders(subtype: String, boundary: String,
                                        headersIn: HashMap<String, String>): HashMap<String, String> {
        MultipartUtils.checkBoundarySyntax(boundary)
        var headersOut: HashMap<String, String> = HashMap<String, String>()
        var contentTypeHeader: String = ""
        let flagContentType: Bool = headersIn.contains(OAuthConstants.CONTENT_TYPE)
        if (flagContentType) {
            contentTypeHeader = headersIn.get(OAuthConstants.CONTENT_TYPE) ?? ""
        }

        if (!flagContentType) {
            contentTypeHeader = "multipart/" + subtype + "; boundary=\"${boundary}\""
            if (!headersIn.isEmpty()) {
                headersOut = headersIn
            }
            headersOut.put(OAuthConstants.CONTENT_TYPE, contentTypeHeader)
        } else {
            headersOut = headersIn
            let parsedBoundary: String = MultipartUtils.parseBoundaryFromHeader(contentTypeHeader)
            if (parsedBoundary.isEmpty()) {
                headersOut.put(OAuthConstants.CONTENT_TYPE, contentTypeHeader + "; boundary=\"${boundary}\"")
            } else if (!(parsedBoundary == boundary)) {
                let err: String = "Different boundaries was passed in constructors. One as argument, second as header"
                throw IllegalArgumentException(err)
            }
        }
        return headersOut
    }