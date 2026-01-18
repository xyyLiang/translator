    func trimTrailingSpaces(buffer: StringBuilder) {
        var length = buffer.size;
        let newContent = buffer.toString().trimAsciiRight()
        if (newContent.size != length) {
            buffer.reset()
            buffer.append(newContent)
        }
    }