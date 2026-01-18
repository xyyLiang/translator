    @Override
    public String getSignature(String baseString, String apiSecret, String tokenSecret) {
        try {
            final Signature signature = Signature.getInstance(RSA_SHA1);
            signature.initSign(privateKey);
            signature.update(baseString.getBytes(UTF8));
            return Base64.encode(signature.sign());
        } catch (NoSuchAlgorithmException | InvalidKeyException | SignatureException | UnsupportedEncodingException
                | RuntimeException e) {
            throw new OAuthSignatureException(baseString, e);
        }
    }