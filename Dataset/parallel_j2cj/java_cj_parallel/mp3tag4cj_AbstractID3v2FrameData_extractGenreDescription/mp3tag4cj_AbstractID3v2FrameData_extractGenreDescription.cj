    protected open func extractGenreDescription(genreValue: String): Option<String> {
        var value: String = genreValue.trim();
        if (value.toRuneArray().size > 0) {
            if (value.toRuneArray()[0] == '(') {
                var pos: Option<Int64> = value.indexOf(')'.toString())
                match (pos) {
                    case Some(x) =>
                        if (x > 0) {
                            return Option<String>.Some(value[x + 1..])
                        }
                    case None => ()
                }
            }
            return Option<String>.Some(value)
        }
        return Option<String>.None
    }