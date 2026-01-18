    public operator func ==(that: OAuth4cjParameter): Bool {
        if (refEq(this, that)) {
            return true
        }
        return (that.getKey() == this.key) && (that.getValue() == this.value)
    }