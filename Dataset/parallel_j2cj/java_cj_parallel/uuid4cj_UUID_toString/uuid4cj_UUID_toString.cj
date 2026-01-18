    public func toString(): String {
        return (toHexString(this.bytes.slice(0, 4)) + "-" +
                toHexString(this.bytes.slice(4, 2)) + "-" +
                toHexString(this.bytes.slice(6, 2)) + "-" +
                toHexString(this.bytes.slice(8, 2)) + "-" +
                toHexString(this.bytes.slice(10, 6)))

    }