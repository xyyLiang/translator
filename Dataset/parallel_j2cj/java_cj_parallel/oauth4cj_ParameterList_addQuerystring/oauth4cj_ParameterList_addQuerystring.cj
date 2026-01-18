    public func addQuerystring(queryStr: String): Unit {
        var queryString: String = queryStr
        while (queryString.endsWith(PARAM_SEPARATOR)) {
            queryString = queryString.trimRight(PARAM_SEPARATOR)
        }
        if (!queryString.isEmpty()) {
            var paramsBuf: Array<String> = Array<String>([queryString])
            if (queryString.contains(PARAM_SEPARATOR)) {
                paramsBuf = queryString.split(PARAM_SEPARATOR)
            }

            for (i in 0..paramsBuf.size) {
                let param: String = paramsBuf[i]

                var pair: Array<String> = Array<String>([param])
                let num: Int64 = queryString.count("=")
                if (num == queryString.size && queryString.contains(PAIR_SEPARATOR)) {
                    pair = Array<String>()
                } else if (queryString.contains(PAIR_SEPARATOR)) {
                    pair = param.split(PAIR_SEPARATOR)
                }

                let key: String = OAuthEncoder.decode(pair[0])
                var value: String = EMPTY_STRING
                if (pair.size > 1) {
                    value = OAuthEncoder.decode(pair[1])
                }
                params.append(OAuth4cjParameter(key, value))
            }
        }
    }