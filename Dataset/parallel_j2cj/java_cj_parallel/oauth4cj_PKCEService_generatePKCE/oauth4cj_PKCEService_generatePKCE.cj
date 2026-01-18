    public func generatePKCE(): PKCE {
        let bytes: Array<UInt8> = Array<UInt8>(Int64(numberOFOctets), item: 0)
        setArrayByRandom(bytes)
        return generatePKCE(bytes)
    }

    private func setArrayByRandom(bytes: Array<UInt8>): Unit {
        RANDOM.seed = UInt64(numberOFOctets)
        for (i in 0..bytes.size) {
            bytes[i] = RANDOM.nextUInt8()
        }
    }