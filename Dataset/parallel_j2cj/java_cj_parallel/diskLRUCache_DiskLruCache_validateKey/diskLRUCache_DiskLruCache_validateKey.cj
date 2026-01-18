    private func validateKey(key: String): Unit {
        let matcher: Option<MatchData> = LEGAL_KEY_PATTERN.matcher(key).fullMatch()

        match (matcher) {
            case Some(_) => ()
            case None => throw DiskLruCacheException("keys must match regex [a-z0-9_-]{1,64}: \"" + "${key}" + "\"")
        }

    }