    static func getTable(t: Char): Table {
        match (t) {
            case 'L' => return Table.LOWER
            case 'P' => return Table.PUNCT
            case 'M' => return Table.MIXED
            case 'D' => return Table.DIGIT
            case 'B' => return Table.BINARY
            case 'U' => return Table.UPPER
            case _ => return Table.UPPER
        }
    }