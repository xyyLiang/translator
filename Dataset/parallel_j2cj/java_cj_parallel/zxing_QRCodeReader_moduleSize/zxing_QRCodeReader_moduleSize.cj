func moduleSize(leftTopBlack: Array<Int64>, image: BitMatrix): Float64 {
    let height = image.height
    let width = image.width
    var x = leftTopBlack[0]
    var y = leftTopBlack[1]
    var inBlack = true
    var transitions = 0
    while (x < width && y < height) {
        if (inBlack != image.get(x, y)) {
            transitions++
            if (transitions == 5) {
                break
            }
            inBlack = !inBlack
        }
        x++
        y++
    }
    if (x == width || y == height) {
        throw NotFoundException()
    }
    Float64(x - leftTopBlack[0]) / 7.0
}