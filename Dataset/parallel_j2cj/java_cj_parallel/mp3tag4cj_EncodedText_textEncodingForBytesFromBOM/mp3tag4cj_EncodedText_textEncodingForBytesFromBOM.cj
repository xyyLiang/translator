    @OverflowWrapping
    private static func textEncodingForBytesFromBOM(value: Array<Int8>): Int8 {
        if (value.size >= 2 && value[0] == Int8(0xff) && value[1] == Int8(0xfe)) {
            return TEXT_ENCODING_UTF_16
        } else if (value.size >= 2 && value[0] == Int8(0xfe) && value[1] == Int8(0xff)) {
            return TEXT_ENCODING_UTF_16BE
        } else if (value.size >= 3 && (value[0] == Int8(0xef) && value[1] == Int8(0xbb) && value[2] == Int8(0xbf))) {
            return TEXT_ENCODING_UTF_8
        } else {
            return TEXT_ENCODING_ISO_8859_1
        }
    }