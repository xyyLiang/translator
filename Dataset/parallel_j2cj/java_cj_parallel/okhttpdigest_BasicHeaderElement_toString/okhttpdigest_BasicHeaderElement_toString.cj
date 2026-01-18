    public func toString(): String {
        var buffer: StringBuilder = StringBuilder()
        buffer.append(this.name)
        if(!this.value.isEmpty()) {
            buffer.append("=")
            buffer.append(this.value)
        }
        for (i in 0..this.parameters.size) {
            buffer.append("; ")
            buffer.append(this.parameters[Int64(i)].getName())
            buffer.append(this.parameters[Int64(i)].getValue())
        }

        return buffer.toString()
    }