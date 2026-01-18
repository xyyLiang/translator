func decodeVersionInformation(versionBits: Int64): ?Version {
    var bestDifference = Int64.Max
    var bestVersion = 0
    for (i in 0..Version.VERSION_DECODE_INFO.size) {
        let targetVersion = Version.VERSION_DECODE_INFO[i]
        if (targetVersion == versionBits) {
            return versionForNumber(i + 7)
        }
        var bitsDifference = numBitsDiffering(versionBits, targetVersion)
        if (bitsDifference < bestDifference) {
            bestVersion = i + 7
            bestDifference = bitsDifference
        }
    }
    if (bestDifference <= 3) {
        return versionForNumber(bestVersion)
    }
    return None
}