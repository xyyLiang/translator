    func increaseCurrentOffset(increaseLength:Int64):Unit{
        this.currentOffset.fetchAdd(increaseLength)
    }