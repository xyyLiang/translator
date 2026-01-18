    public func addPaxHeader(name: String, value: String): Unit {
        try {
            this.processPaxHeader(name, value)
        } catch (ex: Exception) {
            throw  IllegalArgumentException("Invalid input")
        }
    }