    protected func calculateModuleSize(
        topLeft: ResultPoint,
        topRight: ResultPoint,
        bottomLeft: ResultPoint
    ): Float64 {
        (calculateModuleSizeOneWay(topLeft, topRight) + calculateModuleSizeOneWay(topLeft, bottomLeft)) / 2.0
    }