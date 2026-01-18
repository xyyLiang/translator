    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String {
        var pemPri: String = ""
        try {
            pemPri = String.fromUtf8(File(privateKey, OpenOption.Open(true, false)).readToEnd())
        } catch (e: Exception) {
            throw OAuth4cjSignatureException("Illegal private key file!" + e.message)
        }
        try {
            let rsaPri: RSAPrivateKey = RSAPrivateKey.decodeFromPem(pemPri)
            let sha1Instance: SHA1 = SHA1()
            let md: Array<Byte> = digest(sha1Instance, baseString)
            let signArray: Array<Byte> = rsaPri.sign(sha1Instance, md)
            if (signArray.size == 0) {
                throw OAuth4cjSignatureException("RSA-SHA1 algorithm signature failed.")
            }
            return Base64Utils.encode(signArray)
        } catch (e: Exception) {
            throw OAuth4cjSignatureException(e.message)
        }
    }