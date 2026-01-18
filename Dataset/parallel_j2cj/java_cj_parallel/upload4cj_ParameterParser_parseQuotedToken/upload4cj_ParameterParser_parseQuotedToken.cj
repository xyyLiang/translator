    private func parseQuotedToken(terminators:Char): Option<String> {
        i1 = pos
        i2 = pos
        var quoted: Bool = false
        var charEscaped: Bool = false

        while (hasChar()) {
            var ch: Char = chars[pos]
            if (!quoted && this.isOneOf(ch, terminators)) {
                break
            }

            if (!charEscaped && ch == '\"') {
                quoted = !quoted
            }

            charEscaped = (!charEscaped && ch == '\\')
            i2++
            pos++
        }

        return this.getToken(true)
    }