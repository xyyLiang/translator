    public func parseHeaderElement(value: String, parser: HeaderValueParser): HeaderElement {
        Args.notNull(value, "Value")
        var buffer: CharArrayBuffer = CharArrayBuffer(Int32(value.size))
        buffer.append(value)
        let cursor: ParserCursor = ParserCursor(0, Int32(value.size))
        return parser.parseHeaderElement(buffer, cursor)
    }