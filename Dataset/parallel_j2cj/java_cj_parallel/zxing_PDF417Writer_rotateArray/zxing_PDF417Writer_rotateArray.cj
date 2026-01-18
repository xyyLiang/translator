    static func rotateArray(bitarray: Array<Array<UInt8>>): Array<Array<UInt8>> {
        let temp = Array<Array<UInt8>>(bitarray[0].size, {
                n => Array<UInt8>(bitarray.size, item: 0)
            })
        for (ii in 0..bitarray.size) {
            let inverseii = bitarray.size - ii - 1
            for (jj in 0..bitarray[0].size) {
                temp[jj][inverseii] = bitarray[ii][jj]
            }
        }
        temp
    }