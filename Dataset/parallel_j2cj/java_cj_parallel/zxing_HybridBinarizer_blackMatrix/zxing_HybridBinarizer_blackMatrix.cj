    public override func blackMatrix(): BitMatrix {
        if (let Some(m) = matrix) {
            m
        } else {
            let (width, height) = (source.width, source.height)
            let m: BitMatrix = if (width >= MINIMUM_DIMENSION && height >= MINIMUM_DIMENSION) {
                let luminances = source.matrix()
                var subWidth = width >> BLOCK_SIZE_POWER
                if ((width & BLOCK_SIZE_MASK) != 0) {
                    subWidth++
                }
                var subHeight = height >> BLOCK_SIZE_POWER
                if ((height & BLOCK_SIZE_MASK) != 0) {
                    subHeight++
                }
                let blackPoints = calculateBlackPoints(luminances, subWidth, subHeight, width, height)

                let newMatrix = BitMatrix(width, height)
                calculateThresholdForBlock(luminances, subWidth, subHeight, width, height, blackPoints, newMatrix)
                newMatrix
            } else {
                super.blackMatrix()
            }
            this.matrix = m
            m
        }
    }