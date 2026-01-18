    public func setTextEncoding(textEncoding: Int8, _: Bool): Unit {
        if (this.value != Option<Array<Int8>>.None) {
            if (this.textEncoding != textEncoding) {
                var charBuffer: String = bytesToCharBuffer(
                    this.value.getOrThrow(),
                    characterSetForTextEncoding(this.textEncoding)
                )
                var transcodedBytes: Array<Int8> = charBufferToBytes(
                    charBuffer,
                    characterSetForTextEncoding(textEncoding)
                )
                this.textEncoding = textEncoding
                this.value = Option<Array<Int8>>.Some(transcodedBytes)
            }
        }
    }