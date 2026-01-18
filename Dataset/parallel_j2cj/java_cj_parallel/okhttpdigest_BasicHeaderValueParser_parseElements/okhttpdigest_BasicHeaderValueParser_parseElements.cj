    public func parseElements(value: String, parser: HeaderValueParser): ArrayList<BasicHeaderElement> {
         Args.notNull(value, "Value")
         var buffer: CharArrayBuffer = CharArrayBuffer(Int32(value.size))
         buffer.append(value)
         let cursor: ParserCursor = ParserCursor(0, Int32(value.size))
         return parser.parseElements(buffer, cursor)
    }