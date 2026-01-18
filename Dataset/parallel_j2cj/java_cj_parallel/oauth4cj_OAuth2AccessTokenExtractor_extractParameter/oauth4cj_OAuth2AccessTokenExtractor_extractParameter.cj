    private static func extractParameter(response: String, regexPattern: Regex, required: Bool): String {

        let matcher: Matcher = regexPattern.matcher(response)
        let res: Option<MatchData> = matcher.find()
        match (res) {
            case Some(md) => return OAuthEncoder.decode(md.matchStr(1))
            case None =>
                if (required) {
                    let err: String =
                    "Response body is incorrect. Can't extract a '${regexPattern.string()}' from this: '${response}'"
                    throw OAuth4cjException(err)
                }
                return ""
        }
    }