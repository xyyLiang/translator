    public func parseParameters(value: String, parser: HeaderValueParser): ArrayList<BasicNameValuePair> {
        Args.notNull(value, "Value")
        var buffer: CharArrayBuffer = CharArrayBuffer(Int32(value.size))
        buffer.append(value)
        let cursor = ParserCursor(0, Int32(value.size))
        return parser.parseParameters(buffer, cursor)
    }