    private static func characterSetForTextEncoding(textEncoding: Int8): String {
        try {
            return characterSets[Int64(textEncoding)]
        } catch (e: Exception) {
            throw IllegalArgumentException("Invalid text encoding ${textEncoding}")
        }
    }