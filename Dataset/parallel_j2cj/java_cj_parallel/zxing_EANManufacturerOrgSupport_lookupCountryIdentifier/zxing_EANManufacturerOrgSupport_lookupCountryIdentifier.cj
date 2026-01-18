    func lookupCountryIdentifier(productCode: String): ?String {
        initIfNeeded()
        let prefix = Int64.parse(productCode[0..3])
        for (i in 0..ranges.size) {
            let range = ranges[i]
            let start = range[0]
            if (prefix < start) {
                return None
            }
            let end = if (range.size == 1) {
                start
            } else {
                range[1]
            }
            if (prefix <= end) {
                return countryIdentifiers[i]
            }
        }
        None
    }