    public func equals(obj: OAuth4cjResponseException): Bool {
        if (refEq(this, obj)) {
            return true
        }
        return this.response.toString() == obj.getResponse().toString()
    }