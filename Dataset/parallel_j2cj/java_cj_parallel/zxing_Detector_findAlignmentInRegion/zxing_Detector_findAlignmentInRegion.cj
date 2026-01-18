    protected func findAlignmentInRegion(
        overallEstModuleSize: Float64,
        estAlignmentX: Int64,
        estAlignmentY: Int64,
        allowanceFactor: Float64
    ): AlignmentPattern {
        let allowance = Int64(allowanceFactor * overallEstModuleSize)
        let alignmentAreaLeftX = math.max(0, estAlignmentX - allowance)
        let alignmentAreaRightX = math.min(image.width - 1, estAlignmentX + allowance)
        if (Float64(alignmentAreaRightX - alignmentAreaLeftX) < (overallEstModuleSize * 3.0)) {
            throw NotFoundException()
        }

        let alignmentAreaTopY = math.max(0, estAlignmentY - allowance)
        let alignmentAreaBottomY = math.min(image.height - 1, estAlignmentY + allowance)
        if (Float64(alignmentAreaBottomY - alignmentAreaTopY) < (overallEstModuleSize * 3.0)) {
            throw NotFoundException()
        }

        AlignmentPatternFinder(
            image,
            alignmentAreaLeftX,
            alignmentAreaTopY,
            alignmentAreaRightX - alignmentAreaLeftX,
            alignmentAreaBottomY - alignmentAreaTopY,
            overallEstModuleSize,
            resultPointCallback
        ).find()
    }