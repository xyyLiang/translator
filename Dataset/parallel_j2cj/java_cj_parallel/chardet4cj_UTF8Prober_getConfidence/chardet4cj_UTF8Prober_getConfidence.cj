    public func getConfidence(): Float32 {
        var unlike: Float32 = 0.99
        
        if (this.numOfMBChar < 6) {
            for (_ in 0..this.numOfMBChar) {
                unlike *= ONE_CHAR_PROB
            }
            return (1.0 - unlike)
        } else {
            return 0.99
        }
    }