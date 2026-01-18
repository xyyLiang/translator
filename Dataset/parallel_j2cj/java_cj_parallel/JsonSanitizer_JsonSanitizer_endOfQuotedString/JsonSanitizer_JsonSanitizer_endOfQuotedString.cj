    private static func endOfQuotedString(s: CharArray, start: Int64): Int64 {
        let quoteChar = s.charAt(start)
        var i = start
        while (true) {
            i = match(s.indexOf(quoteChar, i + 1)) {
                case Some(val) => val
                case None => break
            }

            // If there are an even number of preceding backslashes then this is
            // the end of the string.
            var slashRunStart = i
            while (slashRunStart > start && s.charAt(slashRunStart - 1) == '\\') {
                slashRunStart--
            }
            if (((i - slashRunStart) & 1) == 0) {
                return i + 1
            }
        }

        return s.size()
    }