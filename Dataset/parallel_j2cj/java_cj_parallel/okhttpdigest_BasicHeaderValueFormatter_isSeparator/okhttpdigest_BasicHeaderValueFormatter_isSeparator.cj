    protected func isSeparator(ch: Char): Bool {
        match (" ;,:@()<>\\\"/[]?={}\t".indexOf(ch)) {
            case Some(v) =>
                return v >= 0
            case _ =>
                return false
        }
    }