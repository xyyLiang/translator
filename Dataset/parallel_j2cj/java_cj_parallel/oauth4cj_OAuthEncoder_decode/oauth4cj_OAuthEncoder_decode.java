    public static String decode(String encoded) {
        Preconditions.checkNotNull(encoded, "Cannot decode null object");
        try {
            return URLDecoder.decode(encoded, CHARSET);
        } catch (UnsupportedEncodingException uee) {
            throw new OAuthException("Charset not found while decoding string: " + CHARSET, uee);
        }
    }