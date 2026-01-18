    public func detect(isMirror: Bool): AztecDetectorResult {
        let pCenter = getMatrixCenter()
        let bullsEyeCorners = getBullsEyeCorners(pCenter)
        if (isMirror) {
            let temp = bullsEyeCorners[0]
            bullsEyeCorners[0] = bullsEyeCorners[2]
            bullsEyeCorners[2] = temp
        }
        extractParameters(bullsEyeCorners)
        let bits = sampleGrid(
            image,
            bullsEyeCorners[shift % 4],
            bullsEyeCorners[(shift + 1) % 4],
            bullsEyeCorners[(shift + 2) % 4],
            bullsEyeCorners[(shift + 3) % 4]
        )
        let corners = getMatrixCornerPoints(bullsEyeCorners)
        AztecDetectorResult(bits, corners, compact, nbDataBlocks, nbLayers)
    }