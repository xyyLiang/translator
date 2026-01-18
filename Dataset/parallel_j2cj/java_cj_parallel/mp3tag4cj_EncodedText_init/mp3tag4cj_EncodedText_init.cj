    public init(textEncoding: Int8, value: Array<Int8>) {
        if ((textEncoding == TEXT_ENCODING_UTF_16)) {
            if (textEncodingForBytesFromBOM(value) == TEXT_ENCODING_UTF_16BE) {
                this.textEncoding = TEXT_ENCODING_UTF_16BE
            } else {
                this.textEncoding = textEncoding
            }
        }else {
            this.textEncoding = textEncoding
        }
        this.value = Option<Array<Int8>>.Some(value)
        this.stripBomAndTerminator();
    }