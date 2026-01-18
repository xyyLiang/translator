    @Override
    public String getRedirectLocation() {
        final Response priorRes = response.priorResponse();
        if (priorRes != null
                && response.isSuccessful()
                && RedirectUtil.isRedirect(priorRes.code())) {
                // prior response is a redirect response, so current response
                // has redirect location
                return response.request().url().toString();
        }
        return null;
    }