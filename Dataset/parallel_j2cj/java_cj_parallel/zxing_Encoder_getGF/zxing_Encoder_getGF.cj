    static func getGF(wordSize: Int64): GenericGF {
        match (wordSize) {
            case 4 => GenericGF.AZTEC_PARAM
            case 6 => GenericGF.AZTEC_DATA_6
            case 8 => GenericGF.AZTEC_DATA_8
            case 10 => GenericGF.AZTEC_DATA_10
            case 12 => GenericGF.AZTEC_DATA_12
            case _ => throw IllegalArgumentException("Unsupported word size ${wordSize}")
        }
    }