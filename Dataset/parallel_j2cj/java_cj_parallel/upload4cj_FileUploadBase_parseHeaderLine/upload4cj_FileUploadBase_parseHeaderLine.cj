    private func parseHeaderLine(headers: FileItemHeadersImpl, header: String): Unit {
        let colonOffset: Option<Int64> = header.indexOf(':')
        if (let Some(i) <- colonOffset) {
            var headerName: String = header.substring(0, i).trimAscii()
            let headerValue: String = header.substring(i + 1).trimAscii()
            headers.addHeader(headerName, headerValue)
        } else {
            return
        }
    }