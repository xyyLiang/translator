    public override func read(b: Array<UInt8>): Int64 {
        let len = input.read(b)
        count(len)
        return len
    }