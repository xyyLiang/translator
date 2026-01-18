func doDecodeFormatInformation(maskedFormatInfo1: Int64, maskedFormatInfo2: Int64): ?FormatInformation {
    var bestDifference = Int64.Max
    var bestFormatInfo = 0
    for (decodeInfo in FormatInformation.FORMAT_INFO_DECODE_LOOKUP) {
        let targetInfo = decodeInfo[0]
        if (targetInfo == maskedFormatInfo1 || targetInfo == maskedFormatInfo2) {
            return FormatInformation(decodeInfo[1])
        }
        var bitsDifference = numBitsDiffering(maskedFormatInfo1, targetInfo)
        if (bitsDifference < bestDifference) {
            bestFormatInfo = decodeInfo[1]
            bestDifference = bitsDifference
        }
        if (maskedFormatInfo1 != maskedFormatInfo2) {
            bitsDifference = numBitsDiffering(maskedFormatInfo2, targetInfo)
            if (bitsDifference < bestDifference) {
                bestFormatInfo = decodeInfo[1]
                bestDifference = bitsDifference
            }
        }
    }
    if (bestDifference <= 3) {
        return FormatInformation(bestFormatInfo)
    }
    return None
}