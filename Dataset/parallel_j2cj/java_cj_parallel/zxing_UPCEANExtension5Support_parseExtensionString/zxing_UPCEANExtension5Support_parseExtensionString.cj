    static func parseExtensionString(raw: String): ?HashMap<ResultMetadataType, Any> {
        if (raw.size != 5) {
            return None
        }
        if (let Some(v) = parseExtension5String(raw)) {
            HashMap<ResultMetadataType, Any>([(ResultMetadataType.SUGGESTED_PRICE, v)])
        } else {
            None
        }
    }
