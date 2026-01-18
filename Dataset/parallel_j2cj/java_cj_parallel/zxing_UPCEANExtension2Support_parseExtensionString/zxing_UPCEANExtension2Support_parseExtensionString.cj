    static func parseExtensionString(raw: String): ?HashMap<ResultMetadataType, Any> {
        if (raw.size != 2) {
            return None
        }
        HashMap<ResultMetadataType, Any>([(ResultMetadataType.ISSUE_NUMBER, Int64.parse(raw))])
    }