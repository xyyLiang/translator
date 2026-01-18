    private func validateInterval(timeInterval: Int64): Unit {
        if(timeInterval <= 0) {
            throw IllegalArgumentException("Interval must be a positive value.")
        }
    }  