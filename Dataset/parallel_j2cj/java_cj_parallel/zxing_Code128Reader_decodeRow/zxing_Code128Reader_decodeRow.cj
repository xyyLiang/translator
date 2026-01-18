    public func decodeRow(rowNumber: Int64, row: BitArray, hints: ?HashMap<DecodeHintType, Any>): Result {
        let convertFNC1 = if (let Some(h) = hints) {
            h.contains(DecodeHintType.ASSUME_GS1)
        } else {
            false
        }

        var symbologyModifier = 0

        let startPatternInfo = findStartPattern(row)
        let startCode = startPatternInfo[2]

        let rawCodes = ArrayList<Int8>([Int8(startCode)])

        var codeSet = if (startCode == CODE_START_A) {
            CODE_CODE_A
        } else if (startCode == CODE_START_B) {
            CODE_CODE_B
        } else if (startCode == CODE_START_C) {
            CODE_CODE_C
        } else {
            throw FormatException()
        }

        var done = false
        var isNextShifted = false

        let result = StringBuilder()

        var lastStart = startPatternInfo[0]
        var nextStart = startPatternInfo[1]
        let counters = Array<Int64>(6, item: 0)

        var lastCode = 0
        var code = 0
        var checksumTotal = startCode
        var multiplier = 0
        var lastCharacterWasPrintable = true
        var upperMode = false
        var shiftUpperMode = false

        while (!done) {
            let unshift = isNextShifted
            isNextShifted = false

            lastCode = code

            code = decodeCode(row, counters, nextStart)

            rawCodes.append(Int8(code))

            if (code != CODE_STOP) {
                lastCharacterWasPrintable = true
            }

            if (code != CODE_STOP) {
                multiplier++
                checksumTotal += multiplier * code
            }

            lastStart = nextStart
            for (counter in counters) {
                nextStart += counter
            }

            if (code == CODE_START_A || code == CODE_START_B || code == CODE_START_C) {
                throw FormatException()
            }

            if (codeSet == CODE_CODE_A) {
                if (code < 64) {
                    if (shiftUpperMode == upperMode) {
                        result.append(Char(UInt32(' ') + UInt32(code)))
                    } else {
                        result.append(Char(UInt32(' ') + UInt32(code) + 128))
                    }
                    shiftUpperMode = false
                } else if (code < 96) {
                    if (shiftUpperMode == upperMode) {
                        result.append(Char(UInt32(code) - 64))
                    } else {
                        result.append(Char(UInt32(code) + 64))
                    }
                    shiftUpperMode = false
                } else {
                    if (code != CODE_STOP) {
                        lastCharacterWasPrintable = false
                    }
                    if (code == CODE_FNC_1) {
                        if (result.size == 0) {
                            symbologyModifier = 1
                        } else if (result.size == 1) {
                            symbologyModifier = 2
                        }
                        if (convertFNC1) {
                            if (result.size == 0) {
                                result.append("]C1")
                            } else {
                                result.append(Char(29))
                            }
                        }
                    } else if (code == CODE_FNC_2) {
                        symbologyModifier = 4
                    } else if (code == CODE_FNC_4_A) {
                        if (!upperMode && shiftUpperMode) {
                            upperMode = true
                            shiftUpperMode = false
                        } else if (upperMode && shiftUpperMode) {
                            upperMode = false
                            shiftUpperMode = false
                        } else {
                            shiftUpperMode = true
                        }
                    } else if (code == CODE_SHIFT) {
                        isNextShifted = true
                        codeSet = CODE_CODE_B
                    } else if (code == CODE_CODE_B || code == CODE_CODE_C) {
                        codeSet = code
                    } else if (code == CODE_STOP) {
                        done = true
                    }
                }
            } else if (codeSet == CODE_CODE_B) {
                if (code < 96) {
                    if (shiftUpperMode == upperMode) {
                        result.append(Char(UInt32(' ') + UInt32(code)))
                    } else {
                        result.append(Char(UInt32(' ') + UInt32(code) + 128))
                    }
                    shiftUpperMode = false
                } else {
                    if (code != CODE_STOP) {
                        lastCharacterWasPrintable = false
                    }
                    if (code == CODE_FNC_1) {
                        if (result.size == 0) {
                            symbologyModifier = 1
                        } else if (result.size == 1) {
                            symbologyModifier = 2
                        }
                        if (convertFNC1) {
                            if (result.size == 0) {
                                result.append("]C1")
                            } else {
                                result.append(Char(29))
                            }
                        }
                    } else if (code == CODE_FNC_2) {
                        symbologyModifier = 4
                    } else if (code == CODE_FNC_4_B) {
                        if (!upperMode && shiftUpperMode) {
                            upperMode = true
                            shiftUpperMode = false
                        } else if (upperMode && shiftUpperMode) {
                            upperMode = false
                            shiftUpperMode = false
                        } else {
                            shiftUpperMode = true
                        }
                    } else if (code == CODE_SHIFT) {
                        isNextShifted = true
                        codeSet = CODE_CODE_A
                    } else if (code == CODE_CODE_A || code == CODE_CODE_C) {
                        codeSet = code
                    } else if (code == CODE_STOP) {
                        done = true
                    }
                }
            }
            if (codeSet == CODE_CODE_C) {
                if (code < 100) {
                    if (code < 10) {
                        result.append('0')
                    }
                    result.append(code)
                } else {
                    if (code != CODE_STOP) {
                        lastCharacterWasPrintable = false
                    }
                    if (code == CODE_FNC_1) {
                        if (result.size == 0) {
                            symbologyModifier = 1
                        } else if (result.size == 1) {
                            symbologyModifier = 2
                        }
                        if (convertFNC1) {
                            if (result.size == 0) {
                                result.append("]C1")
                            } else {
                                result.append(Char(29))
                            }
                        }
                    } else if (code == CODE_CODE_A || code == CODE_CODE_B) {
                        codeSet = code
                    } else if (code == CODE_STOP) {
                        done = true
                    }
                }
            }

            if (unshift) {
                codeSet = if (codeSet == CODE_CODE_A) {
                    CODE_CODE_B
                } else {
                    CODE_CODE_A
                }
            }
        }

        let lastPatternSize = nextStart - lastStart

        nextStart = row.nextUnset(nextStart)
        if (!row.isRange(
            nextStart,
            math.min(row.size, nextStart + (nextStart - lastStart) / 2),
            false
        )) {
            throw NotFoundException()
        }

        checksumTotal -= multiplier * lastCode
        if (checksumTotal % 103 != lastCode) {
            throw ChecksumException()
        }

        let resultLength = result.size
        if (resultLength == 0) {
            throw NotFoundException()
        }

        if (resultLength > 0 && lastCharacterWasPrintable) {
            if (codeSet == CODE_CODE_C) {
                result.remove((resultLength - 2)..resultLength)
            } else {
                result.remove((resultLength - 1)..resultLength)
            }
        }

        let left = Float64(startPatternInfo[1] + startPatternInfo[0]) / 2.0
        let right = Float64(lastStart) + Float64(lastPatternSize) / 2.0

        let rawCodesSize = rawCodes.size
        let rawBytes = Array<UInt8>(rawCodesSize, {n => UInt8(rawCodes[n])})

        let resultObject = Result(
            result.toString(),
            rawBytes,
            [
                ResultPoint(left, Float64(rowNumber)),
                ResultPoint(right, Float64(rowNumber))
            ],
            BarcodeFormat.CODE_128
        )
        resultObject.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]C${symbologyModifier}")
        resultObject
    }