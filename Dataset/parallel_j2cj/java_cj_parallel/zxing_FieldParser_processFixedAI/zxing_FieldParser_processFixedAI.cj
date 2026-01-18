    static func processFixedAI(aiSize: Int64, fieldSize: Int64, rawInformation: String): String {
        if (rawInformation.size < aiSize) {
            throw NotFoundException()
        }

        let ai = rawInformation[0..aiSize]

        if (rawInformation.size < aiSize + fieldSize) {
            throw NotFoundException()
        }

        let field = rawInformation.substring(aiSize, aiSize + fieldSize)
        let remaining = rawInformation.substring(aiSize + fieldSize)
        let result = "(${ai})${field}"
        let parsedAI = parseFieldsInGeneralPurpose(remaining)
        if (let Some(p) = parsedAI) {
            "${result}${p}"
        } else {
            result
        }
    }