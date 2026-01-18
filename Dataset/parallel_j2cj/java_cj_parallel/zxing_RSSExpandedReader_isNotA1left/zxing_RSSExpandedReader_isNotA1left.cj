    static func isNotA1left(pattern: ?FinderPattern, isOddPattern: Bool, leftChar: Bool): Bool {
        !(pattern.getOrThrow().value == 0 && isOddPattern && leftChar)
    }
