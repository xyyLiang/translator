    public func contains(param: OAuth4cjParameter): Bool {
        for (pa in this.params) {
            if (pa == param) {
                return true
            }
        }
        return false
    }