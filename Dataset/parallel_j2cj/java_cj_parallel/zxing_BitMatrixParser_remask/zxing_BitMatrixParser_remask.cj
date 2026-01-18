    func remask() {
        if (let Some(d) = this.parsedFormatInfo) {
            let dataMask = DataMask.parse(Int64(d.dataMask))
            dataMask.unmaskBitMatrix(bitMatrix, this.bitMatrix.height)
        }
    }