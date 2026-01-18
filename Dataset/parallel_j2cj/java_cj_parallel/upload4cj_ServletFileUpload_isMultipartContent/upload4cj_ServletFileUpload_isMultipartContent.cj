    public static func isMultipartContent(request: HttpRequest): Bool {
        let requestMethod: String = request.method.toString().toAsciiLower()
        let lowerPost = POST_METHOD.toAsciiLower()
        if (!lowerPost.equals(requestMethod)) {
            return false
        }
        return FileUploadBase.isMultipartContent(ServletRequestContext(request))
    }