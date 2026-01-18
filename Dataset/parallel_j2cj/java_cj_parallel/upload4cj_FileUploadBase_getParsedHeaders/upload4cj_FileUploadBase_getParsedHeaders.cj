    protected func getParsedHeaders(headerPart: String): FileItemHeaders {
        let len: Int64 = headerPart.size
        let headers: FileItemHeadersImpl = newFileItemHeaders()
        var start: Int64 = 0
        while (true) {
            var end = parseEndOfLine(headerPart, start)
            if (start == end) {
                break
            }
            let header: StringBuilder = StringBuilder(headerPart.substring(start, end - start))
            start = end + 2
            while (start < len) {
                var nonWs = start
                while (nonWs < len) {
                    let c: Char = headerPart.toRuneArray().get(nonWs).getOrThrow()
                    if (c != ' ' && c != '\t') {
                        break
                    }
                    nonWs++
                }
                if (nonWs == start) {
                    break
                }

                // Continuation line found
                end = parseEndOfLine(headerPart, nonWs)
                header.append(" ")
                header.append(headerPart.substring(nonWs, end - nonWs))
                start = end + 2
            }
            parseHeaderLine(headers, header.toString())
        }
        return headers
    }