    public func asFormUrlEncodedString(): String {
        if (params.isEmpty()) {
            return EMPTY_STRING
        }

        let builder: StringBuilder = StringBuilder()
        var isFirst: Bool = true
        for (param in params) {
            if (isFirst) {
                isFirst = false
                builder.append(param.asUrlEncodedPair())
                continue
            }
            builder.append(PARAM_SEPARATOR)
            builder.append(param.asUrlEncodedPair())
        }
        return builder.toString()
    }