    Lexer(format: CSVParseFormat, reader: CSVReader) {
        this.format = format
        this.reader = reader
        this.delimiter = format.getDelimiterRuneArray()
        this.escape = format.getEscapeCharacter()
        this.quoteChar = format.getQuoteCharacter()
        this.commentStart = format.getCommentMarker()
        this.ignoreSurroundingSpaces = format.getIgnoreSurroundingSpaces()
        this.ignoreEmptyLines = format.getIgnoreEmptyLines()
        this.delimiterBuf = Array<Rune>(delimiter.size - 1, item: Constants.DISABLED)
        this.escapeDelimiterBuf = Array<Rune>(2 * delimiter.size - 1, item: Constants.DISABLED)
    }