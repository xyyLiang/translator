    public func parse(charArray: Option<Array<Char>>, separator: Char): Map<String, Option<String>> {
        match (charArray) {
            case None => return HashMap<String, Option<String>>()
            case Some(_) => return this.parse(charArray, 0, charArray.getOrThrow().size, separator)
        }
    }