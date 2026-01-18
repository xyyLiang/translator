    protected func addWeightCode(buf: StringBuilder, weight: Int64): Unit {
        buf.append('(')
        buf.append(this.firstAIdigits)
        buf.append(weight / 100000)
        buf.append(')')
    }