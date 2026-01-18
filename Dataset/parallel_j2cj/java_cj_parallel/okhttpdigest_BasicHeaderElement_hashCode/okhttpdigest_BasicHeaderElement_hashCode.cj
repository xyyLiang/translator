    public func hashCode(): Int32 {
        let hash: Int32 = 17
        var var3 = LangUtils.hashCode(hash, this.name)
        var3 = LangUtils.hashCode(var3, this.value)
        for (i in 0..this.parameters.size) {
            var3 = LangUtils.hashCode(var3, this.parameters[i])
        }
        return var3
    }