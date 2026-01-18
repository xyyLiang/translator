    static func decodeMacroBlock(codewords: Array<Int64>, ocodeIndex: Int64, resultMetadata: PDF417ResultMetadata): Int64 {
        if (ocodeIndex + NUMBER_OF_SEQUENCE_CODEWORDS > codewords[0]) {
            throw FormatException()
        }
        var codeIndex = ocodeIndex
        let segmentIndexArray = Array<Int64>(NUMBER_OF_SEQUENCE_CODEWORDS, item: 0)
        for (i in 0..NUMBER_OF_SEQUENCE_CODEWORDS) {
            segmentIndexArray[i] = codewords[codeIndex]
            codeIndex++
        }
        let segmentIndexString = decodeBase900toBase10(segmentIndexArray, NUMBER_OF_SEQUENCE_CODEWORDS)
        if (segmentIndexString.isEmpty()) {
            resultMetadata.segmentIndex = 0
        } else {
            if (let Some(v) = Int64.tryParse(segmentIndexString)) {
                resultMetadata.segmentIndex = v
            } else {
                throw FormatException()
            }
        }
        let fileId = StringBuilder()
        while (codeIndex < codewords[0] && codeIndex < codewords.size && codewords[codeIndex] != MACRO_PDF417_TERMINATOR&&
                codewords[codeIndex] != BEGIN_MACRO_PDF417_OPTIONAL_FIELD) {
            fileId.append(codewords[codeIndex].format("03"))
            codeIndex++
        }
        if (fileId.size == 0) {
            throw FormatException()
        }
        resultMetadata.fileId = fileId.toString()
        var optionalFieldsStart = -1
        if (codewords[codeIndex] == BEGIN_MACRO_PDF417_OPTIONAL_FIELD) {
            optionalFieldsStart = codeIndex + 1
        }

        while (codeIndex < codewords[0]) {
            let code = codewords[codeIndex]
            if (code == BEGIN_MACRO_PDF417_OPTIONAL_FIELD) {
                codeIndex++
                let code = codewords[codeIndex]
                if (code == MACRO_PDF417_OPTIONAL_FIELD_FILE_NAME) {
                    let fileName = StringBuilder()
                    codeIndex = textCompaction(codewords, codeIndex + 1, fileName)
                    resultMetadata.fileName = fileName.toString()
                } else if (code == MACRO_PDF417_OPTIONAL_FIELD_SENDER) {
                    let sender = StringBuilder()
                    codeIndex = textCompaction(codewords, codeIndex + 1, sender)
                    resultMetadata.sender = sender.toString()
                } else if (code == MACRO_PDF417_OPTIONAL_FIELD_ADDRESSEE) {
                    let addressee = StringBuilder()
                    codeIndex = textCompaction(codewords, codeIndex + 1, addressee)
                    resultMetadata.addressee = addressee.toString()
                } else if (code == MACRO_PDF417_OPTIONAL_FIELD_SEGMENT_COUNT) {
                    let segmentCount = StringBuilder()
                    codeIndex = numericCompaction(codewords, codeIndex + 1, segmentCount)
                    if (let Some(v) = Int64.tryParse(segmentCount.toString())) {
                        resultMetadata.segmentCount = v
                    } else {
                        throw FormatException()
                    }
                } else if (code == MACRO_PDF417_OPTIONAL_FIELD_TIME_STAMP) {
                    let timestamp = StringBuilder()
                    codeIndex = numericCompaction(codewords, codeIndex + 1, timestamp)
                    if (let Some(v) = Int64.tryParse(timestamp.toString())) {
                        resultMetadata.timestamp = v
                    } else {
                        throw FormatException()
                    }
                } else if (code == MACRO_PDF417_OPTIONAL_FIELD_CHECKSUM) {
                    let checksum = StringBuilder()
                    codeIndex = numericCompaction(codewords, codeIndex + 1, checksum)
                    if (let Some(v) = Int64.tryParse(checksum.toString())) {
                        resultMetadata.checksum = v
                    } else {
                        throw FormatException()
                    }
                } else if (code == MACRO_PDF417_OPTIONAL_FIELD_FILE_SIZE) {
                    let fileSize = StringBuilder()
                    codeIndex = numericCompaction(codewords, codeIndex + 1, fileSize)
                    if (let Some(v) = Int64.tryParse(fileSize.toString())) {
                        resultMetadata.fileSize = v
                    } else {
                        throw FormatException()
                    }
                } else {
                    throw FormatException()
                }
            } else if (code == MACRO_PDF417_TERMINATOR) {
                codeIndex++
                resultMetadata.lastSegment = true
            } else {
                throw FormatException()
            }
        }

        if (optionalFieldsStart != -1) {
            var optionalFieldsLength = codeIndex - optionalFieldsStart
            if (resultMetadata.lastSegment) {
                optionalFieldsLength--
            }
            if (optionalFieldsLength > 0) {
                resultMetadata.optionalData = codewords[optionalFieldsStart..(optionalFieldsStart + optionalFieldsLength)]
            }
        }
        codeIndex
    }