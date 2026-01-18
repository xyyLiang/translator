    private func getFieldName(pContentDisposition: Option<String>): Option<String> {
        var fieldName: Option<String> = Option<String>.None
        if (let Some(i) <- pContentDisposition) {
            let cdl: String = i.toAsciiLower()
            if (cdl.startsWith(FORM_DATA)) {
                let parser: ParameterParser = ParameterParser()
                parser.setLowerCaseNames(true)
                let params: Map<String, Option<String>> = parser.parse(i, ';')
                fieldName = params.get("name").getOrThrow()
                if (let Some(j) <- fieldName) {
                    fieldName = j.trimAscii()
                }
            }
        }
        return fieldName
    }