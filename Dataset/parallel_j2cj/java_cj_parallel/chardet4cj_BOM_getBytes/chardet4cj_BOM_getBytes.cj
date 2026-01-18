    public func getBytes(): Array<Byte> {

        let length = bytes.size
        var result: Array<Byte> = Array<Byte>(length, item: 0)
        this.bytes.copyTo(result,0,0,length)
        return result
    }