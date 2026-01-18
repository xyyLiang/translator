    protected func processFinderPatternInfo(info: FinderPatternInfo): DetectorResult {
        let topLeft = info.topLeft
        let topRight = info.topRight
        let bottomLeft = info.bottomLeft

        let moduleSize = calculateModuleSize(topLeft, topRight, bottomLeft)
        if (moduleSize < 1.0) {
            throw NotFoundException()
        }
        let dimension = computeDimension(topLeft, topRight, bottomLeft, moduleSize)
        let provisionalVersion = provisionalVersionForDimension(dimension)
        let modulesBetweenFPCenters = provisionalVersion.dimensionForVersion() - 7

        var alignmentPattern: ?AlignmentPattern = None
        if (provisionalVersion.alignmentPatternCenters.size > 0) {
            let bottomRightX = topRight.x - topLeft.x + bottomLeft.x
            let bottomRightY = topRight.y - topLeft.y + bottomLeft.y

            let correctionToTopLeft = 1.0 - 3.0 / Float64(modulesBetweenFPCenters)
            let estAlignmentX = Int64(topLeft.x + correctionToTopLeft * (bottomRightX - topLeft.x))
            let estAlignmentY = Int64(topLeft.y + correctionToTopLeft * (bottomRightY - topLeft.y))

            var i = 4
            while (i <= 16) {
                try {
                    alignmentPattern = findAlignmentInRegion(
                        moduleSize,
                        estAlignmentX,
                        estAlignmentY,
                        Float64(i)
                    )
                    break
                } catch (re: NotFoundException) {}
                i <<= 1
            }
        }

        let transform = createTransform(topLeft, topRight, bottomLeft, alignmentPattern, dimension)

        let bits = sampleGrid(image, transform, dimension)

        let points: Array<ResultPoint> = if (let Some(pattern) = alignmentPattern) {
            [bottomLeft, topLeft, topRight, pattern]
        } else {
            [bottomLeft, topLeft, topRight]
        }
        DetectorResult(bits, points)
    }