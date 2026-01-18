    private func numericsOnly(s: String): String {
        var stringBuffer: StringBuilder = StringBuilder()
        for (index in 0..s.toRuneArray().size) {
            var ch: Char = s.toRuneArray()[index]
            if (ch >= '0' && ch <= '9') {
                stringBuffer.append(ch)
            } else {
                break
            }
        }
        return stringBuffer.toString()
    }