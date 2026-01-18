    func sampleGrid(
        image: BitMatrix,
        topLeft: ResultPoint,
        topRight: ResultPoint,
        bottomRight: ResultPoint,
        bottomLeft: ResultPoint
    ): BitMatrix {
        let sampler = GridSampler.gridSampler
        let dimension = getDimension()

        let low = Float64(dimension) / 2.0 - Float64(nbCenterLayers)
        let high = Float64(dimension) / 2.0 + Float64(nbCenterLayers)

        sampler.sampleGrid(
            image,
            dimension,
            dimension,
            low,
            low, // topleft
            high,
            low, // topright
            high,
            high, // bottomright
            low,
            high, // bottomleft
            topLeft.x,
            topLeft.y,
            topRight.x,
            topRight.y,
            bottomRight.x,
            bottomRight.y,
            bottomLeft.x,
            bottomLeft.y
        )
    }
