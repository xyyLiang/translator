    static func nextIdentChar(ch: Char, allowDigits: Bool): ?Char {
        match(ch) {
            case 'z' => 'A'
            case 'Z' => '_'
            case '_' => '$'
            case '$' => 
                if (allowDigits) {
                    '0'
                } else {
                    None
                }
            case '9' => None
            case _ => Char(UInt32(ch) + 1)
        }
    }