    private static func stringToBytes(s: String, characterSet: String): Option<Array<Int8>> {
        try {
            return charBufferToBytes(s, characterSet);
        } catch (e: Exception) {
            return Option<Array<Int8>>.None
        }
    }