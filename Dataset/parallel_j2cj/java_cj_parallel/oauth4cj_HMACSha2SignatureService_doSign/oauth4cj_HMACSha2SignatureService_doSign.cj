    private func doSign(toSign: String, keyString: String): String {
        let algorithm: AlgorithmType = AlgorithmType.Sha1
        let key: Array<UInt8> = keyString.toArray()
        let data: Array<UInt8> = toSign.toArray()
        let md: Array<UInt8> = Array<UInt8>(Int64(AlgorithmType.Sha1.getBits()), item: 0)

        hmac(algorithm, key, data, md)
        return Base64Utils.encode(md).replace(CARRIAGE_RETURN, EMPTY_STRING)
    }