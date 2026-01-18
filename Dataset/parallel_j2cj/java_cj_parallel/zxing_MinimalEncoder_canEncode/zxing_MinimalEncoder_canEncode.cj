    func canEncode(contents: String, charset: MinimalEncoderCharset, position: Int64): Bool {
        let c = contents.charAt(position)
        match (charset) {
            case A =>
                c == Code128Writer.ESCAPE_FNC_1 || c == Code128Writer.ESCAPE_FNC_2 || c == Code128Writer.ESCAPE_FNC_3 ||
                    c == Code128Writer.ESCAPE_FNC_4 || if (let None = A.indexOf(c)) {
                    false
                } else {
                    true
                }
            case B =>
                c == Code128Writer.ESCAPE_FNC_1 || c == Code128Writer.ESCAPE_FNC_2 || c == Code128Writer.ESCAPE_FNC_3 ||
                    c == Code128Writer.ESCAPE_FNC_4 || if (let None = B.indexOf(c)) {
                    false
                } else {
                    true
                }
            case C =>
                c == Code128Writer.ESCAPE_FNC_1 || (position + 1 < contents.size && isDigit(c) && isDigit(
                    contents.charAt(position + 1)))
            case _ => false
        }
    }