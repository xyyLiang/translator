    protected func getBoundary(contentType: String): Option<Array<UInt8>> {
        let parser: ParameterParser = ParameterParser()
        parser.setLowerCaseNames(true)
        let charArray = Array<Char>([';', ','])
        let params: Map<String, Option<String>> = parser.parse(contentType, charArray)
        let boundaryStr: Option<Option<String>> = params.get("boundary")
        if (let Some(k) <- boundaryStr) {
            if (let Some(_) <- k) {
                var boundary: Array<UInt8>
                try {
                    //仓颉目前只支持utf-8
                    boundary = k.getOrThrow().toUtf8Array()
                } catch (e: UnsupportedEncodingException) {
                    throw UnsupportedEncodingException("encoding exception")
                }
                return boundary
            } else {
                return Option<Array<UInt8>>.None
            }
        } else {
            return Option<Array<UInt8>>.None
        }
    }