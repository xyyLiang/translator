    private func getFileName(pContentDisposition: Option<String>): Option<String> {
        var fileName: Option<String> = Option<String>.None
        if (let Some(i) <- pContentDisposition) {
            let cdl: String = i.toAsciiLower()
            if (cdl.startsWith(FORM_DATA) || cdl.startsWith(ATTACHMENT)) {
                let parser: ParameterParser = ParameterParser()
                parser.setLowerCaseNames(true)
                let params: Map<String, Option<String>> = parser.parse(i, ';')
                if (params.contains("filename")) {
                    fileName = params.get("filename").getOrThrow()
                    if (let Some(j) <- fileName) {
                        fileName = j.trimAscii()
                    } else {
                        fileName = ""
                    }
                }
            }
        }
        return fileName
    }