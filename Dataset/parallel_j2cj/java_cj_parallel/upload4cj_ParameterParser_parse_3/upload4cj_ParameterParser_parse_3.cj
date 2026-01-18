    public func parse(charArray: Option<Array<Char>>, offset: Int64, length: Int64, separator: Char): Map<String, Option<String>> {
        match (charArray) {
            case None => return HashMap<String, Option<String>>()
            case Some(_) => this.chars = charArray.getOrThrow()
        }
        var params: HashMap<String, Option<String>> = HashMap<String, Option<String>>()

        this.pos = offset
        this.len = length
        var paramName: Option<String>
        var paramValue: Option<String>

        while (hasChar()) {
            paramName = parseToken('=', separator)
            paramValue = Option<String>.None
            if (hasChar() && charArray.getOrThrow()[pos] == '=') {
                pos++
                paramValue = this.parseQuotedToken(separator)

                try {
                    paramValue = MimeUtility.decodeText(paramValue.getOrThrow())
                } catch (e: Exception) {
                    // let's keep the original value in this case
                }
            }

            if (hasChar() && (charArray.getOrThrow()[pos] == separator)) {
                pos++ // skip separator
            }

            let isParamName = match (paramName) {
                case None => false
                case Some(_) => true
            }

            if (isParamName && (paramName.getOrThrow().size > 0)) {
                if (lowerCaseNames) {
                    paramName = paramName.getOrThrow().toAsciiLower()
                }
                params.put(paramName.getOrThrow(), paramValue)
            }
        }
        return params
    }