    public static func isMultipartContent(ctx: RequestContext): Bool {
        let contentType: Option<String> = ctx.getContentType()
        if (let Some(i) <- contentType) {
            let lowerStr: String = i.toAsciiLower()
            if (lowerStr.startsWith(MULTIPART)) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }