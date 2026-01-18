    public func formatNameValuePair(buffer: StringBuilder, nvp: NameValuePair, quotes: Bool): StringBuilder {
        var charBuffer = buffer
        charBuffer.append(nvp.getName())
        let value: String = nvp.getValue()
        if(!value.isEmpty()) {
            charBuffer.append('=')
            this.doFormatValue(charBuffer, value, quotes)
        }
        return charBuffer
    }