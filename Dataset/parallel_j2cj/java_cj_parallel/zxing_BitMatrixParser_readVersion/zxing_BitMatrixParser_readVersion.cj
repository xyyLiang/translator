    func readVersion(): Version {
        if (let Some(d) = this.parsedVersion) {
            return d
        }

        let dimension = bitMatrix.height

        let provisionalVersion = (dimension - 17) / 4
        if (provisionalVersion <= 6) {
            return versionForNumber(provisionalVersion)
        }

        var versionBits = 0
        let ijMin = dimension - 11
        for (j in 5..=0 : -1) {
            for (i in (dimension - 9)..=ijMin : -1) {
                versionBits = copyBit(i, j, versionBits)
            }
        }

        var theParsedVersion = decodeVersionInformation(versionBits)
        if (let Some(d) = theParsedVersion) {
            if (d.dimensionForVersion() == dimension) {
                this.parsedVersion = d
                return d
            }
        }

        versionBits = 0
        for (i in 5..=0 : -1) {
            for (j in (dimension - 9)..=ijMin : -1) {
                versionBits = copyBit(i, j, versionBits)
            }
        }

        theParsedVersion = decodeVersionInformation(versionBits)
        if (let Some(d) = theParsedVersion) {
            if (d.dimensionForVersion() == dimension) {
                this.parsedVersion = d
                return d
            }
        }
        throw FormatException()
    }