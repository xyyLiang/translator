    public func toBytes(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(TAG_LENGTH), {_ => 0})
        packTag(bytes)
        return bytes
    }