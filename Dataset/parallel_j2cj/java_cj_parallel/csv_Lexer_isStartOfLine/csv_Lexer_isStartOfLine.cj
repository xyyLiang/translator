    func isStartOfLine(ch: Option<Rune>): Bool {
        if (let Some(value) <- ch) {
            return value == Constants.LF || value == Constants.CR
        } else {
            return true
        }
    }