    public func getQueryStringParams(): ParameterList {
        let urlArr: Array<String> = url.split(":")
        if (urlArr.size <= 1) {
            throw OAuth4cjException("Malformed URL! no protocol: ${url}!")
        }
        let urlHeader: String = (urlArr[0]).toAsciiLower()
        let urlIsTrue: Bool = urlHeader.startsWith("http") || urlHeader.startsWith("https") ||
            urlHeader.startsWith("file") || urlHeader.startsWith("mailto") || urlHeader.startsWith("ftp")
        if (!urlIsTrue) {
            throw OAuth4cjException("Malformed URL! unknown protocol: ${urlHeader}!")
        }
        try {
            let result: ParameterList = ParameterList()
            let queryString: String = URL.parse(url).rawQuery ?? ""
            result.addQuerystring(queryString)
            result.addAll(querystringParams)
            return result
        } catch (e: Exception) {
            throw OAuth4cjException("Malformed URL! " + e.message)
        }
    }