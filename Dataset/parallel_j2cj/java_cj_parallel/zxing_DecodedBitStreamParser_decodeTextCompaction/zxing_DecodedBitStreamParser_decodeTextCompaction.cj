    static func decodeTextCompaction(
        textCompactionData: Array<Int64>,
        byteCompactionData: Array<Int64>,
        length: Int64,
        result: StringBuilder,
        startMode: DecodedBitStreamParserMode
    ): DecodedBitStreamParserMode {
        var subMode = startMode
        var priorToShiftMode = startMode
        var latchedMode = startMode
        var i = 0
        while (i < length) {
            let subModeCh = UInt32(textCompactionData[i])
            var ch = Char(0)
            match (subMode) {
                case ALPHA =>
                    if (subModeCh < 26) {
                        ch = Char(UInt32('A') + subModeCh)
                    } else {
                        let sm = Int64(subModeCh)
                        if (subModeCh == 26) {
                            ch = ' '
                        } else if (sm == LL) {
                            subMode = LOWER
                            latchedMode = subMode
                        } else if (sm == ML) {
                            subMode = MIXED
                            latchedMode = subMode
                        } else if (sm == PS) {
                            priorToShiftMode = subMode
                            subMode = PUNCT_SHIFT
                        } else if (sm == MODE_SHIFT_TO_BYTE_COMPACTION_MODE) {
                            result.append(Char(byteCompactionData[i]))
                        } else if (sm == TEXT_COMPACTION_MODE_LATCH) {
                            subMode = ALPHA
                            latchedMode = subMode
                        }
                    }

                case LOWER =>
                    if (subModeCh < 26) {
                        ch = Char(UInt32('a') + subModeCh)
                    } else {
                        let sm = Int64(subModeCh)
                        if (subModeCh == 26) {
                            ch = ' '
                        } else if (sm == AS) {
                            priorToShiftMode = subMode
                            subMode = ALPHA_SHIFT
                        } else if (sm == ML) {
                            subMode = MIXED
                            latchedMode = subMode
                        } else if (sm == PS) {
                            priorToShiftMode = subMode
                            subMode = PUNCT_SHIFT
                        } else if (sm == MODE_SHIFT_TO_BYTE_COMPACTION_MODE) {
                            result.append(Char(byteCompactionData[i]))
                        } else if (sm == TEXT_COMPACTION_MODE_LATCH) {
                            subMode = ALPHA
                            latchedMode = subMode
                        }
                    }

                case MIXED =>
                    if (Int64(subModeCh) < PL) {
                        ch = MIXED_CHARS[Int64(subModeCh)]
                    } else {
                        let sm = Int64(subModeCh)
                        if (sm == PL) {
                            subMode = PUNCT
                            latchedMode = subMode
                        } else if (subModeCh == 26) {
                            ch = ' '
                        } else if (sm == LL) {
                            subMode = LOWER
                            latchedMode = subMode
                        } else if (sm == AL) {
                            subMode = ALPHA
                            latchedMode = subMode
                        } else if (sm == TEXT_COMPACTION_MODE_LATCH) {
                            subMode = ALPHA
                            latchedMode = subMode
                        } else if (sm == PS) {
                            priorToShiftMode = subMode
                            subMode = PUNCT_SHIFT
                        } else if (sm == MODE_SHIFT_TO_BYTE_COMPACTION_MODE) {
                            result.append(Char(byteCompactionData[i]))
                        }
                    }

                case PUNCT =>
                    if (Int64(subModeCh) < PAL) {
                        ch = PUNCT_CHARS[Int64(subModeCh)]
                    } else {
                        let sm = Int64(subModeCh)
                        if (sm == PAL) {
                            subMode = ALPHA
                            latchedMode = subMode
                        } else if (sm == TEXT_COMPACTION_MODE_LATCH) {
                            subMode = ALPHA
                            latchedMode = subMode
                        } else if (sm == MODE_SHIFT_TO_BYTE_COMPACTION_MODE) {
                            result.append(Char(byteCompactionData[i]))
                        }
                    }

                case ALPHA_SHIFT =>
                    subMode = priorToShiftMode
                    if (Int64(subModeCh) < 26) {
                        ch = Char(UInt32('A') + subModeCh)
                    } else {
                        match (subModeCh) {
                            case 26 => ch = ' '
                            case TEXT_COMPACTION_MODE_LATCH => subMode = ALPHA
                        }
                    }

                case PUNCT_SHIFT =>
                    subMode = priorToShiftMode
                    if (Int64(subModeCh) < PAL) {
                        ch = PUNCT_CHARS[Int64(subModeCh)]
                    } else {
                        let sm = Int64(subModeCh)
                        if (sm == PAL) {
                            subMode = ALPHA
                        } else if (sm == TEXT_COMPACTION_MODE_LATCH) {
                            subMode = ALPHA
                        } else if (sm == MODE_SHIFT_TO_BYTE_COMPACTION_MODE) {
                            result.append(Char(byteCompactionData[i]))
                        }
                    }
            }
            if (ch != Char(0)) {
                result.append(ch)
            }
            i++
        }
        latchedMode
    }