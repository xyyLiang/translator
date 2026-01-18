    public init(string: String) {
        for (textEncodingTmp in textEncodingFallback) {
            this.textEncoding = textEncodingTmp
            value = stringToBytes(string, characterSetForTextEncoding(textEncoding))
            match (value) {
                case Some(_) =>
                    if (this.toString() != Option<String>.None) {
                        this.stripBomAndTerminator()
                        return
                    }
                case None => ()
            }
        }
        throw IllegalArgumentException("Invalid string, could not find appropriate encoding");
    }