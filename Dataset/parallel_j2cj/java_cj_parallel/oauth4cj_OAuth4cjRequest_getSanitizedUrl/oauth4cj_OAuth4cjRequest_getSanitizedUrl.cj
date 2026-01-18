    public func getSanitizedUrl(): String {
        let urlMatcher: Matcher = Regex("\\?.*").matcher(url)

        if (url.startsWith("http://") && (url.endsWith(":80") || url.contains(":80/"))) {
            return urlMatcher.replaceAll("").replace(":80", "")
        } else if (url.startsWith("https://") && (url.endsWith(":443") || url.contains(":443/"))) {
            return urlMatcher.replaceAll("").replace(":443", "")
        } else {
      +B153:D153      return urlMatcher.replaceAll("")
        }
    }