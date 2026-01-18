    func read0(): Int64 {
        return match {
            case currentState == EOF => -1
            case currentState == START_BLOCK_STATE => setupBlock()
            case currentState == RAND_PART_A_STATE => throw CompressorException("IllegalState")
            case currentState == RAND_PART_B_STATE => setupRandPartB()
            case currentState == RAND_PART_C_STATE => setupRandPartC()
            case currentState == NO_RAND_PART_A_STATE => throw CompressorException("IllegalState")
            case currentState == NO_RAND_PART_B_STATE => setupNoRandPartB()
            case currentState == NO_RAND_PART_C_STATE => setupNoRandPartC()
            case _ => throw CompressorException("IllegalState")
        }
    }