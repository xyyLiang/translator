    private func isAsciiSymbol(b: Byte): Bool {
        let c: Int32 = Int32(Int64(b) & 0xFF)
        return ((c < ASCII_A_CAPITAL) ||
                (c > ASCII_Z_CAPITAL && c < ASCII_A) ||
                (c > ASCII_Z))
    }