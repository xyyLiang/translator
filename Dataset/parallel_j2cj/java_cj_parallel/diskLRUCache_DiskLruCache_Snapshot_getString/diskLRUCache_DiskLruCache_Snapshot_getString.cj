    public func getString(index: Int64): String {
        buff.reset()
        let file = getInputStream(index)
        var read = file.read(buffArr)
        while (read != 0) {
            buff.appendFromUtf8(buffArr.slice(0, read))
            read = file.read(buffArr)
        }
        return buff.toString()
    }