    public open func getBearerSignature(): BearerSignature {
        return BearerSignatureAuthorizationRequestHeaderField.instance()
    }