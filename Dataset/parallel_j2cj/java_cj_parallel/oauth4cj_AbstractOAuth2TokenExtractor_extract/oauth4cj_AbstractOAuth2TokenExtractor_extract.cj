    private func extract(response: String, p: Regex): String {
        let matcher: Matcher = p.matcher(response)
        let res: Option<MatchData> = matcher.find()
        match (res) {
            case Some(md) =>
                if (md.groupNumber() == 0) {
                    return OAuthEncoder.decode("")
                }
                return OAuthEncoder.decode(md.matchStr(1))
            case None =>
                let err: String = "Response body is incorrect. Can't extract token and secret from this: '${response}'"
                throw OAuth4cjException(err)
        }
    }