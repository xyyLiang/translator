
    public PKCE generatePKCE() {
        final byte[] bytes = new byte[numberOFOctets];
        RANDOM.nextBytes(bytes);
        return generatePKCE(bytes);
    }