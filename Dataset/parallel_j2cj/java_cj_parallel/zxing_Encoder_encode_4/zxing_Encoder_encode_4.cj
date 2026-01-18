    public static func encode(content: String, ecLevel: ErrorCorrectionLevel, hints: ?HashMap<EncodeHintType, Any>): QRCode {
        let hasGS1FormatHint = if (let Some(h) = hints) {
            if (let Some(gs1) = h.get(EncodeHintType.GS1_FORMAT)) {
                if (gs1 is Bool) {
                    (gs1 as Bool).getOrThrow()
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
        let hasCompactionHint = if (let Some(h) = hints) {
            if (let Some(gs1) = h.get(EncodeHintType.QR_COMPACT)) {
                if (gs1 is Bool) {
                    (gs1 as Bool).getOrThrow()
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }

        let (version, headerAndDataBits, mode): (Version, BitArray, Mode) = if (hasCompactionHint) {
            let mode = Mode.BYTE
            let rn = MinimalEncoder.encode(content, None, hasGS1FormatHint, ecLevel)
            let headerAndDataBits = BitArray()
            rn.getBits(headerAndDataBits)
            (rn.version, headerAndDataBits, mode)
        } else {
            let mode = chooseMode(content)
            let headerBits = BitArray()
            if (hasGS1FormatHint) {
                appendModeInfo(Mode.FNC1_FIRST_POSITION, headerBits)
            }
            appendModeInfo(mode, headerBits)

            let dataBits = BitArray()
            appendBytes(content, mode, dataBits)

            let version: Version = if (let Some(h) = hints) {
                if (let Some(qrVersion) = h.get(EncodeHintType.QR_VERSION)) {
                    let versionNumber = (qrVersion as Int64).getOrThrow()
                    let v = versionForNumber(versionNumber)
                    let bitsNeeded = calculateBitsNeeded(mode, headerBits, dataBits, v)
                    if (!willFit(bitsNeeded, v, ecLevel)) {
                        throw WriterException("Data too big for requested version")
                    }
                    v
                } else {
                    recommendVersion(ecLevel, mode, headerBits, dataBits)
                }
            } else {
                recommendVersion(ecLevel, mode, headerBits, dataBits)
            }

            let headerAndDataBits = BitArray()
            headerAndDataBits.appendBitArray(headerBits)
            let numLetters = if (mode == Mode.BYTE) {
                dataBits.sizeInBytes()
            } else {
                content.size
            }
            appendLengthInfo(numLetters, version, mode, headerAndDataBits)
            headerAndDataBits.appendBitArray(dataBits)
            (version, headerAndDataBits, mode)
        }

        let ecBlocks = version.ecBlocksForLevel(ecLevel)
        let numDataBytes = version.totalCodewords - ecBlocks.totalECCodewords()

        terminateBits(numDataBytes, headerAndDataBits)

        let finalBits = interleaveWithECBytes(
            headerAndDataBits,
            version.totalCodewords,
            numDataBytes,
            ecBlocks.numBlocks()
        )

        let qrCode = QRCode()
        qrCode.ecLevel = ecLevel
        qrCode.mode = mode
        qrCode.version = version

        let dimension = version.dimensionForVersion()
        let matrix = ByteMatrix(dimension, dimension)

        var maskPattern = -1
        if (let Some(h) = hints) {
            if (let Some(qr) = h.get(EncodeHintType.QR_MASK_PATTERN)) {
                let hintMaskPattern = (qr as Int64).getOrThrow()
                maskPattern = if (isValidMaskPattern(hintMaskPattern)) {
                    hintMaskPattern
                } else {
                    -1
                }
            }
        }

        if (maskPattern == -1) {
            maskPattern = chooseMaskPattern(finalBits, ecLevel, version, matrix)
        }
        qrCode.maskPattern = maskPattern

        buildMatrix(finalBits, ecLevel, version, maskPattern, matrix)
        qrCode.matrix = matrix

        qrCode
    }