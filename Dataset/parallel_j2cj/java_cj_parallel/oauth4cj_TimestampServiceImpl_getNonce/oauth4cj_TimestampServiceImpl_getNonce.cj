    public func getNonce(): String {
        let ts: Int64 = getTs()
        return (ts + Int64(timer.getRandomInteger())).toString()
    }