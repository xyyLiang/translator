    private String doSign(String toSign, String keyString) throws UnsupportedEncodingException,
            NoSuchAlgorithmException, InvalidKeyException {
        final SecretKeySpec key = new SecretKeySpec(keyString.getBytes(UTF8), HMAC_SHA1);
        final Mac mac = Mac.getInstance(HMAC_SHA1);
        mac.init(key);
        final byte[] bytes = mac.doFinal(toSign.getBytes(UTF8));
        return Base64.encode(bytes).replace(CARRIAGE_RETURN, EMPTY_STRING);
    }