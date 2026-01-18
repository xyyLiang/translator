    public void revokeToken(String tokenToRevoke) throws IOException, InterruptedException, ExecutionException {
        revokeToken(tokenToRevoke, (TokenTypeHint) null);
    }