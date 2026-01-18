    static func processVariableAI(aiSize: Int64, variableFieldSize: Int64, rawInformation: String): String {
        let ai = rawInformation[0..aiSize]
        let maxSize = math.min(rawInformation.size, aiSize + variableFieldSize)
        let field = rawInformation[aiSize..maxSize]
        let remaining = rawInformation[maxSize..rawInformation.size]
        let result = "(${ai})${field}"
        let parsedAI = parseFieldsInGeneralPurpose(remaining)
        if (let Some(p) = parsedAI) {
            "${result}${p}"
        } else {
            result
        }
    }