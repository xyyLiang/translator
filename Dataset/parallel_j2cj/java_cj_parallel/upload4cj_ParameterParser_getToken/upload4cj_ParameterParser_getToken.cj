    private func getToken(quoted: Bool): Option<String> {
        // Trim leading white spaces
        while ((i1 < i2) && (chars[i1].isAsciiWhiteSpace())) {
            i1++
        }

        // Trim trailing white spaces
        while ((i2 > i1) && (chars[i2 - 1].isAsciiWhiteSpace())) {
            i2--
        }

        // Strip away quotation marks if necessary
        if (quoted && ((i2 - i1) >= 2) && (chars[i1] == '\"') && (chars[i2 - 1] == '\"')) {
            i1++
            i2--
        }
        var result = Option<String>.None
        if (i2 > i1) {
            result = String(chars.slice(i1,i2 - i1))
            //result = String(chars, start: i1, length: i2 - i1)
        }
        return result
    }