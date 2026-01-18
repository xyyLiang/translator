    static func encodeHighLevel(msg: String, compaction: Compaction, autoECI: Bool): String {
        if (msg.isEmpty()) {
            throw WriterException("Empty message not allowed")
        }

        if (!autoECI) {
            for (i in 0..msg.size) {
                if (UInt32(msg.charAt(i)) > 255) {
                    throw WriterException(
                        "Non-encodable character detected: ${msg.charAt(i)} (Unicode: ${UInt32(msg.charAt(i))}). Consider specifying EncodeHintType.PDF417_AUTO_ECI and/or EncodeTypeHint.CHARACTER_SET."
                    )
                }
            }
        }

        let sb = StringBuilder()
        let input: ECIInput = if (autoECI) {
            MinimalECIInput(msg, -1)
        } else {
            NoECIInput(msg)
        }

        let len = input.length()
        var p = 0
        var textSubMode = SUBMODE_ALPHA

        match (compaction) {
            case TEXT => encodeText(input, p, len, sb, textSubMode)
            case BYTE =>
                if (autoECI) {
                    encodeMultiECIBinary(input, 0, input.length(), TEXT_COMPACTION, sb)
                } else {
                    let msgBytes = input.toString().toUtf8Array()
                    encodeBinary(msgBytes, p, msgBytes.size, BYTE_COMPACTION, sb)
                }
            case NUMERIC =>
                sb.append(Char(LATCH_TO_NUMERIC))
                encodeNumeric(input, p, len, sb)
            case _ =>
                var encodingMode = TEXT_COMPACTION

                //Default mode, see 4.4.2.1
                while (p < len) {
                    while (p < len && input.isECI(p)) {
                        encodingECI(input[p], sb)
                        p++
                    }
                    if (p >= len) {
                        break
                    }
                    let n = determineConsecutiveDigitCount(input, p)
                    if (n >= 13) {
                        sb.append(Char(LATCH_TO_NUMERIC))
                        encodingMode = NUMERIC_COMPACTION
                        textSubMode = SUBMODE_ALPHA

                        encodeNumeric(input, p, n, sb)
                        p += n
                    } else {
                        let t = determineConsecutiveTextCount(input, p)
                        if (t >= 5 || n == len) {
                            if (encodingMode != TEXT_COMPACTION) {
                                sb.append(Char(LATCH_TO_TEXT))
                                encodingMode = TEXT_COMPACTION
                                textSubMode = SUBMODE_ALPHA
                            }
                            textSubMode = encodeText(input, p, t, sb, textSubMode)
                            p += t
                        } else {
                            var b = determineConsecutiveBinaryCount(input, p)
                            if (b == 0) {
                                b = 1
                            }
                            let bytes: ?Array<UInt8> = if (autoECI) {
                                None
                            } else {
                                input[p..(p + b)].toUtf8Array()
                            }
                            if ((if (let None = bytes) {
                                true
                            } else {
                                false
                            } && b == 1) || (if (let None = bytes) {
                                false
                            } else {
                                true
                            } && bytes.getOrThrow().size == 1) && encodingMode == TEXT_COMPACTION) {
                                if (autoECI) {
                                    encodeMultiECIBinary(input, p, 1, TEXT_COMPACTION, sb)
                                } else {
                                    encodeBinary(bytes.getOrThrow(), 0, 1, TEXT_COMPACTION, sb)
                                }
                            } else {
                                if (autoECI) {
                                    encodeMultiECIBinary(input, p, p + b, encodingMode, sb)
                                } else {
                                    encodeBinary(bytes.getOrThrow(), 0, bytes.getOrThrow().size, encodingMode, sb)
                                }
                                encodingMode = BYTE_COMPACTION
                                textSubMode = SUBMODE_ALPHA
                            }

                            p += b
                        }
                    }
                }
        }

        sb.toString()
    }