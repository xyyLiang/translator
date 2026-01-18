    @OverflowWrapping
    public open func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = 1
        if (unsynchronisation) {
            result = prime * result + 1231
        } else {
            result = prime * result + 1237
        }
        return Int64(result)
    }