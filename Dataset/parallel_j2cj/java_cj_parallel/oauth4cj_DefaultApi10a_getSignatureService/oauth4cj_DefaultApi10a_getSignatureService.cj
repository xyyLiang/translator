    public open func getSignatureService(): SignatureService {
        return HMACSha1SignatureService()
    }