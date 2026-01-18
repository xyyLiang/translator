func getDataMaskBit(maskPattern: Int64, x: Int64, y: Int64): Bool {
    let intermediate = match (maskPattern) {
        case 0 => (y + x) & 0x1
        case 1 => y & 0x1
        case 2 => x % 3
        case 3 => (y + x) % 3
        case 4 => ((y / 2) + (x / 3)) & 0x1
        case 5 =>
            let temp = y * x
            (temp & 0x1) + (temp % 3)
        case 6 =>
            let temp = y * x
            ((temp & 0x1) + (temp % 3)) & 0x1
        case 7 =>
            let temp = y * x
            ((temp % 3) + ((y + x) & 0x1)) & 0x1
        case _ => throw IllegalArgumentException("Invalid mask pattern: ${maskPattern}")
    }
    intermediate == 0
}