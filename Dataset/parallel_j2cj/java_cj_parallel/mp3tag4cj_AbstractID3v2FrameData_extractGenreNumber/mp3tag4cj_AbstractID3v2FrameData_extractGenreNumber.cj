    protected open func extractGenreNumber(genreValue: String): Option<Int64> {
        var value: String = genreValue.trim()
        if (value.toRuneArray().size > 0) {
            if (value.toRuneArray()[0] == '(') {
                var pos: Option<Int64> = value.indexOf(')'.toString())
                match (pos) {
                    case Some(x) =>
                        if (x > 0) {
                            return Option<Int64>.Some(Int64.parse(value[1..x - "(".size + 1]))
                        }
                    case None => ()
                }
            }
        }
        return Option<Int64>.Some(Int64.parse(value))
    }