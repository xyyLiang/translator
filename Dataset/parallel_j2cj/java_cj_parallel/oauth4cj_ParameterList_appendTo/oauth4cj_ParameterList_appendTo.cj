    public func appendTo(url: String): String {
        let queryString: String = asFormUrlEncodedString()
        if (queryString == EMPTY_STRING) {
            return url
        } else {
            let separatorNum: Int64 = url.indexOf(QUERY_STRING_SEPARATOR) ?? -1
            var separatorString: String = PARAM_SEPARATOR
            if (separatorNum == -1) {
                separatorString = QUERY_STRING_SEPARATOR.toString()
            }

            return url + separatorString + queryString
        }
    }
