    private func isJsonSpecialChar(i: Int64): Bool {
        let ch = jsonish.charAt(i)
        if (ch <= ' ') {
            return true
        }
        match(ch) {
            case '"' | ',' | ':' | '[' | ']' | '{' | '}' => return true
            case _ => return false
        }
    }