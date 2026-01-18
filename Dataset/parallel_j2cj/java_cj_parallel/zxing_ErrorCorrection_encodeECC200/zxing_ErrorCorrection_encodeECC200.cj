    static func encodeECC200(codewords: String, symbolInfo: SymbolInfo): String {
        if (codewords.size != symbolInfo.dataCapacity) {
            throw IllegalArgumentException("The number of codewords does not match the selected symbol");
        }
        let sb = StringBuilder();
        sb.append(codewords);
        let blockCount = symbolInfo.getInterleavedBlockCount();
        if (blockCount == 1) {
            let ecc = createECCBlock(codewords, symbolInfo.errorCodewords);
            sb.append(ecc);
        } else {
            sb.remove(0..(symbolInfo.dataCapacity + symbolInfo.errorCodewords))
            let dataSizes = Array<Int64>(blockCount, item: 0)
            let errorSizes = Array<Int64>(blockCount, item: 0)
            for (i in 0..blockCount) {
                dataSizes[i] = symbolInfo.getDataLengthForInterleavedBlock(i + 1)
                errorSizes[i] = symbolInfo.getErrorLengthForInterleavedBlock(i + 1)
            }
            for (block in 0..blockCount) {
                let temp = StringBuilder();
                for (d in block..symbolInfo.dataCapacity : blockCount) {
                    temp.append(codewords.charAt(d));
                }
                let ecc = createECCBlock(temp.toString(), errorSizes[block]);
                var pos = 0;
                for (e in block..(errorSizes[block] * blockCount) : blockCount) {
                    let idx = symbolInfo.dataCapacity + e
                    sb.remove(idx)
                    sb.insert(idx, ecc.charAt(pos));
                    pos++
                }
            }
        }
        sb.toString()
    }