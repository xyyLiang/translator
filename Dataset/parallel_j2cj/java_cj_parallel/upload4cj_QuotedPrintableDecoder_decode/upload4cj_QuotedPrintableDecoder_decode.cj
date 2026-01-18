    public static func decode(data: Array<UInt8>): String {
        var off: Int64 = 0
        var length: Int64 = data.size
        var endOffset: Int64 = off + length

        var out: ByteArrayStream = ByteArrayStream()

        while (off < endOffset) {
            var ch: UInt8 = data[off]
            off++
            if (Char(ch) == '_') {
                out.write(String(' ').toUtf8Array())
            } else if (Char(ch) == '=') {
                if (off + 1 >= endOffset) {
                    throw QDecoderException("Invalid quoted printable encoding; truncated escape sequence")
                }
                let b1: UInt8 = data[off]
                off++
                let b2: UInt8 = data[off]
                off++

                if (Char(b1) == '\r') {
                    if (Char(b2) != '\n') {
                        throw QDecoderException("Invalid quoted printable encoding; CR must be followed by LF")
                    }
                } else {
                    let b: UInt8 = hexToBinary(b1, b2)
                    out.write(b)
                }
            } else {
                out.write(ch)
            }
        }
        if (out.length == 0) {
            return ""
        }
        var str = ""
        unsafe{
            str = String.fromUtf8Unchecked(out.readToEnd())
        }
        return str
    }