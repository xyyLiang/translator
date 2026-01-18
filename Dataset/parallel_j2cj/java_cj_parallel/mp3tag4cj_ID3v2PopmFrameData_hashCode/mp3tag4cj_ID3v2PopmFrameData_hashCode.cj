    @OverflowWrapping
    public override func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = Int32(super.hashCode())
        if (address == Option<String>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(address.getOrThrow().hashCode())
        }
        result = prime * result + rating
        return Int64(result)
    }