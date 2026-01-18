func decode(bytes: Array<UInt8>, version: Version, ecLevel: ?ErrorCorrectionLevel, hints: ?HashMap<DecodeHintType, Any>): DecoderResult {
    let bits = BitSource(bytes)
    let result = StringBuilder()
    let byteSegments = ArrayList<Array<UInt8>>()
    var symbolSequence = -1
    var parityData = -1
    var symbologyModifier = 0

    try {
        var fc1InEffect = false
        var hasFNC1first = false
        var hasFNC1second = false
        var isECI = false
        var mode = Mode.NUMERIC
        func doFunc() {
            if (bits.available() < 4) {
                mode = Mode.TERMINATOR
            } else {
                mode = Mode.forBits(bits.readBits(4))
            }
            match (mode) {
                case TERMINATOR => ()
                case FNC1_FIRST_POSITION =>
                    hasFNC1first = true
                    fc1InEffect = true
                case STRUCTURED_APPEND =>
                    if (bits.available() < 16) {
                        throw FormatException()
                    }
                    symbolSequence = bits.readBits(8)
                    parityData = bits.readBits(8)
                case ECI =>
                    parseECIValue(bits)
                    isECI = true
                case HANZI =>
                    let subset = bits.readBits(4)
                    let countHanzi = bits.readBits(mode.getCharacterCountBits(version))
                    if (subset == DecodedBitStreamParser.GB2312_SUBSET) {
                        decodeHanziSegment(bits, result, countHanzi)
                    }
                case _ =>
                    let count = bits.readBits(mode.getCharacterCountBits(version))
                    match (mode) {
                        case NUMERIC => decodeNumericSegment(bits, result, count)
                        case ALPHANUMERIC => decodeAlphanumericSegment(bits, result, count, fc1InEffect)

                        case BYTE => decodeByteSegment(bits, result, count, byteSegments, hints)

                        case KANJI => decodeKanjiSegment(bits, result, count)

                        case _ => throw FormatException()
                    }
            }
        }
        doFunc()
        while (mode != Mode.TERMINATOR) {
            doFunc()
        }

        symbologyModifier = if (isECI) {
            if (hasFNC1first) {
                4
            } else if (hasFNC1second) {
                6
            } else {
                2
            }
        } else {
            if (hasFNC1first) {
                3
            } else if (hasFNC1second) {
                5
            } else {
                1
            }
        }
    } catch (e: IllegalArgumentException) {
        throw FormatException()
    }
    DecoderResult(
        bytes,
        result.toString(),
        if (byteSegments.isEmpty()) {
            None
        } else {
            byteSegments
        },
        if (let Some(e) = ecLevel) {
            e.toString()
        } else {
            None
        },
        symbolSequence,
        parityData,
        symbologyModifier
    )
}