    private func parseEndOfLine(headerPart: String, end: Int64): Int64 {
        var index: Int64 = end
        while (true) {
            let offset: Option<Int64> = headerPart.indexOf("\r", index)

            if (let Some(i) <- offset) {
                if (i + 1 >= headerPart.size) {
                    throw IllegalStateException("Expected headers to be terminated by an empty line.")
                }
            } else {
                throw IllegalStateException("Expected headers to be terminated by an empty line.")
            }
            if (headerPart.toRuneArray().get(offset.getOrThrow() + 1).getOrThrow() == '\n') {
                return offset.getOrThrow()
            }
            index = offset.getOrThrow() + 1
        }
        return 0
    }