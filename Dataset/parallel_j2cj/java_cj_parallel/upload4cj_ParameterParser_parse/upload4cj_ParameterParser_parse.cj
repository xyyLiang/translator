    public func parse(str: Option<String>, separators: Option<Array<Char>>): Map<String, Option<String>> {
        match (separators) {
            case None => return HashMap<String, Option<String>>()
            case Some(_) =>
                if (separators.getOrThrow().size == 0) {
                    return HashMap<String, Option<String>>()
                }
        }

        var separator: Char = separators.getOrThrow()[0]
        let isStr = match (str) {
            case None => false
            case Some(_) => true
        }

        if (isStr) {
            var idx: Int64 = str.getOrThrow().size
            for (separatorChar in separators.getOrThrow()) {
                var tmp: Option<Int64> = str.getOrThrow().indexOf(separatorChar)
                let isTmp = match (tmp) {
                    case None => false
                    case Some(_) => true
                }
                if (isTmp && tmp.getOrThrow() < idx) {
                    idx = tmp.getOrThrow()
                    separator = separatorChar
                }
            }
        }
        return parse(str, separator)
    }