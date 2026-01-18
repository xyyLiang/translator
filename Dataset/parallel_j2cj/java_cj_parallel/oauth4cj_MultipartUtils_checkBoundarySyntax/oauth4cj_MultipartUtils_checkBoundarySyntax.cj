    public static func checkBoundarySyntax(boundary: String): Unit {
        if (boundary.isEmpty()) {
            let err: String = "{'boundary'='" + boundary + "'} has invalid syntax. Should be '" +
                                BOUNDARY_PATTERN + "'."
            throw IllegalArgumentException(err)
        }
        let matcher: Matcher = BOUNDARY_REGEXP.matcher(boundary)
        let res: Option<MatchData> = matcher.fullMatch()

        func insideGet(): Exception {
            let err: String = "{'boundary'='" + boundary + "'} has invalid syntax. Should be '" +
                                BOUNDARY_PATTERN + "'."
            throw IllegalArgumentException(err)
        }
        res.getOrThrow(insideGet)
        return ()
    }