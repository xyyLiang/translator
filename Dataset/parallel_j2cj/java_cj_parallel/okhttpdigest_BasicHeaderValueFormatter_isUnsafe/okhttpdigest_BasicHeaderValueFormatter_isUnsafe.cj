    protected func isUnsafe(ch: Char): Bool {
        match ("\"\\".indexOf(ch)) {
            case Some(v) =>
                return v >= 0
            case _ =>
                return false
        }
    }