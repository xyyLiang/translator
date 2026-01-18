    @overflowWrapping
    public override func row(y: Int64, r: Array<Int8>): Array<Int8> {
        let row = this.delegate.row(y, r)
        for (i in 0..this.width) {
            row[i] = Int8(Int8(255) - (row[i] & Int8(0xff)))
        }
        row
    }