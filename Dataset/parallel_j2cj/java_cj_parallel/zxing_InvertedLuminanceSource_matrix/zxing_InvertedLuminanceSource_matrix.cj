    @overflowWrapping
    public override func matrix(): Array<UInt8> {
        let m = this.delegate.matrix()
        let length = this.width * this.height
        let invertedMatrix = Array<UInt8>(length, item: 0)
        for (i in 0..length) {
            invertedMatrix[i] = UInt8(255 - (m[i] & 0xFF))
        }
        invertedMatrix
    }
