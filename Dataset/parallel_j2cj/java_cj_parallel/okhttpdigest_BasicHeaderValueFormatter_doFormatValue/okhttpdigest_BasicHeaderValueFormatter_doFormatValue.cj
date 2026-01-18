    protected func doFormatValue(buffers: StringBuilder, value: String, quotes: Bool) {
        var buffer = buffers
        var quoteFlag: Bool = quotes
        if(!quotes) {
            for (i in 0..value.size) {
                quoteFlag = this.isSeparator(value.charAt(i))
            }
        }

        if(quoteFlag) {
            buffer.append('\"')
        }
        for (i in 0..value.size) {
            var ch = value.charAt(i)
            if(this.isUnsafe(ch)) {
                buffer.append('\\')
            }

            buffer.append(ch)
        }

        if(quoteFlag) {
            buffer.append('\"')
        }
    }