    static func checkCodewordSkew(codewordSize: Int64, minCodewordWidth: Int64, maxCodewordWidth: Int64): Bool {
        minCodewordWidth - CODEWORD_SKEW_SIZE <= codewordSize && codewordSize <= maxCodewordWidth + CODEWORD_SKEW_SIZE
    }