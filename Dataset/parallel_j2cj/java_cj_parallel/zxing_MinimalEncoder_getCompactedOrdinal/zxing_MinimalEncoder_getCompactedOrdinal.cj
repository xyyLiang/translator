    func getCompactedOrdinal(mode: ?Mode): Int64 {
        if (let Some(m) = mode) {
            match (m) {
                case KANJI => 0
                case ALPHANUMERIC => 1
                case NUMERIC => 2
                case BYTE => 3
                case _ => throw Exception("Illegal mode ${mode}")
            }
        } else {
            0
        }
    }