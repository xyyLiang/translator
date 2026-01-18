    public static func parseBoundaryFromHeader(contentTypeHeader: String): String {
        if (contentTypeHeader.isEmpty()) {
            return ""
        }
        let matcher: Matcher = BOUNDARY_FROM_HEADER_REGEXP.matcher(contentTypeHeader)

        let res: Option<MatchData> = matcher.find()
        match (res) {
            case Some(md) => return md.matchStr(1)
            case None => return ""
        }
    }