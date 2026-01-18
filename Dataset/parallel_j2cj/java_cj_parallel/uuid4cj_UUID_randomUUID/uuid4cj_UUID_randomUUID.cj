    public static func randomUUID(): UUID {
        let ng: SecureRandom = SecureRandom(priv: false)
        let randomBytes = ng.nextBytes(16)
        randomBytes[6]  &= 0x0f  /* clear version        */
        randomBytes[6]  |= 0x40  /* set to version 4     */
        randomBytes[8]  &= 0x3f  /* clear variant        */
        randomBytes[8]  |= 0x80  /* set to IETF variant  */
        return UUID(randomBytes)
    }