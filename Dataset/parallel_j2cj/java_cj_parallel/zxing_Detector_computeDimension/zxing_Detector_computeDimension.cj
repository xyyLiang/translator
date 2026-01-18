func computeDimension(
    topLeft: ResultPoint,
    topRight: ResultPoint,
    bottomLeft: ResultPoint,
    moduleSize: Float64
): Int64 {
    let tltrCentersDimension = util.round(distance(topLeft, topRight) / moduleSize)
    let tlblCentersDimension = util.round(distance(topLeft, bottomLeft) / moduleSize)
    var dimension = (Int64(tltrCentersDimension + tlblCentersDimension) / 2) + 7
    match (dimension & 0x03) {
        case 0 => dimension++

        case 2 => dimension--

        case 3 => throw NotFoundException()
        case _ => ()
    }
    dimension
}