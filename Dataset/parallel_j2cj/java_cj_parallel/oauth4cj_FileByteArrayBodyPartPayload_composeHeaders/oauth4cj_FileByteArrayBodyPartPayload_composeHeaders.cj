    private static func composeHeaders(contentType: String, name: String, filename: String,
            contentTypeNull!: Bool = false, nameNull!: Bool = false, filenameNull!: Bool = false):
            HashMap<String, String> {

        var contentDispositionHeader: String = "form-data"
        if (!nameNull) {
            contentDispositionHeader += "; name=\"${name}\""
        }
        if (!filenameNull) {
            contentDispositionHeader += "; filename=\"${filename}\""
        }
        let headers: HashMap<String, String> = HashMap<String, String>()

        if (contentTypeNull) {
            headers.put("Content-Disposition", contentDispositionHeader)
            return headers
        }

        headers.put(OAuthConstants.CONTENT_TYPE, contentType)
        headers.put("Content-Disposition", contentDispositionHeader)
        return headers
    }