    public func compareTo(val: UUID): Int32 {

        let bytesFirstValue: UInt64 = UInt64.parse("0x" + toHexString(this.bytes.slice(0, 5)))
        let bytesMidValue: UInt64 = UInt64.parse("0x" + toHexString(this.bytes.slice(5, 5)))
        let bytesEndValue: UInt64 = UInt64.parse("0x" + toHexString(this.bytes.slice(10, 6)))

        let uuidFirstValue: UInt64 = UInt64.parse("0x" + toHexString(val.getBytes().slice(0, 5)))
        let uuidMidValue: UInt64 = UInt64.parse("0x" + toHexString(val.getBytes().slice(5, 5)))
        let uuidEndValue: UInt64 = UInt64.parse("0x" + toHexString(val.getBytes().slice(10, 6)))

        if(bytesFirstValue < uuidFirstValue) {
            return -1     
        } else if(bytesFirstValue > uuidFirstValue) {
            return 1
        } else if(bytesMidValue < uuidMidValue) {
            return -1
        } else if(bytesMidValue > uuidMidValue) {
            return 1
        } else if(bytesEndValue < uuidEndValue) {
            return -1
        } else if(bytesEndValue > uuidEndValue) {
            return 1
        } else {
            return 0
        }
    }