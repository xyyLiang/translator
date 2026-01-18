    private func getExpressionSetSummary(set: QzTreeSet<Int64>): String {
        if (set.contains(NO_SPEC)) {
            return "?"
        }
        if (set.contains(ALL_SPEC)) {
            return "*"
        }

        let buf = StringBuilder()

        var first = true
        for( val in set ) {
            if (!first) {
                buf.append(",")
            }
            buf.append(val)
            first = false            
        }

        return buf.toString()
    }    