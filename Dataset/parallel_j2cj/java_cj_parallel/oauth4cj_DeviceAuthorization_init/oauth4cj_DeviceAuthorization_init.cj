    public init(deviceCode: String, userCode: String, verificationUri: String, expiresInSeconds: Int64) {
        this.deviceCode = deviceCode
        this.userCode = userCode
        this.verificationUri = verificationUri
        if (expiresInSeconds < 0) {
            throw OAuth4cjException("The validity time of the verification code cannot be negative")
        }
        this.expiresInSeconds = expiresInSeconds
    }