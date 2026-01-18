    private func elideTrailingComma(closeBracketPos: Int64): Unit {
        // The content before closeBracketPos is stored in two places.
        // 1. sanitizedJson
        // 2. jsonish.substring(cleaned, closeBracketPos-cleaned)
        // We walk over whitespace characters in both right-to-left looking for a
        // comma.
        for (i in closeBracketPos-1..=cleaned:-1) {
            match(jsonish.charAt(i)) {
                case '\t' | '\n' | '\r' | ' ' => continue
                case ',' => 
                    elide(i, i + 1)
                    return;
                case _ => throw AssertionError(jsonish.charAt(i).toString())
            }
        }

        let sanitizedJson = this.sanitizedJson.getOrThrow()
        for (i in sanitizedJson.size()-1..=0:-1) {
            match(sanitizedJson.charAt(i)) {
                case '\t' | '\n' | '\r' | ' ' => continue
                case ',' => 
                    sanitizedJson.removeFromIndex(i)
                    return;
                case _ => throw AssertionError(sanitizedJson.charAt(i).toString())
            }
        }

        throw AssertionError("Trailing comma not found in ${jsonish} or ${sanitizedJson}")
    }