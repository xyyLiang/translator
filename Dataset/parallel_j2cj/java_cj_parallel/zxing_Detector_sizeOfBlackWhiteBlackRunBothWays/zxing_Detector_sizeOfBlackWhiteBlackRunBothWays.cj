    func sizeOfBlackWhiteBlackRunBothWays(fromX: Int64, fromY: Int64, toX: Int64, toY: Int64): Float64 {
        var result = sizeOfBlackWhiteBlackRun(fromX, fromY, toX, toY)

        var scale = 1.0
        var otherToX = fromX - (toX - fromX)
        if (otherToX < 0) {
            scale = Float64(fromX) / Float64(fromX - otherToX)
            otherToX = 0
        } else if (otherToX >= image.width) {
            scale = Float64(image.width - 1 - fromX) / Float64(otherToX - fromX)
            otherToX = image.width - 1
        }
        var otherToY = Int64(Float64(fromY) - Float64(toY - fromY) * scale)

        scale = 1.0
        if (otherToY < 0) {
            scale = Float64(fromY) / Float64(fromY - otherToY)
            otherToY = 0
        } else if (otherToY >= image.height) {
            scale = Float64(image.height - 1 - fromY) / Float64(otherToY - fromY)
            otherToY = image.height - 1
        }
        otherToX = Int64(Float64(fromX) + Float64(otherToX - fromX) * scale)

        result + sizeOfBlackWhiteBlackRun(fromX, fromY, otherToX, otherToY) - 1.0
    }