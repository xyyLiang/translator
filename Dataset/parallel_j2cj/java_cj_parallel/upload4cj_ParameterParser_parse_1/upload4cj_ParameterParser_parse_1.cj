    public func parse(str: Option<String>, separator: Char): Map<String, Option<String>> {
        match (str) {
            case None => return HashMap<String, Option<String>>()
            case Some(_) =>
                let charArray: Option<Array<Char>> = str.getOrThrow().toCharArray()
                return this.parse(charArray, separator)
        }
    }