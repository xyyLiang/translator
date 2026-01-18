func calculateBCHCode(oValue: Int64, poly: Int64): Int64 {
    if (poly == 0) {
        throw IllegalArgumentException("0 polynomial")
    }
    let msbSetInPoly = findMSBSet(poly)
    var value = oValue
    value <<= msbSetInPoly - 1
    while (findMSBSet(value) >= msbSetInPoly) {
        value ^= poly << (findMSBSet(value) - msbSetInPoly)
    }
    return value
}
