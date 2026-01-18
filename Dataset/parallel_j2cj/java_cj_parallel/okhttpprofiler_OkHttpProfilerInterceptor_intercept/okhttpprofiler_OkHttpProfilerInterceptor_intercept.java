    @NotNull
    @Override
    public Response intercept(Chain chain) throws IOException {
        String id = generateId();
        long startTime = System.currentTimeMillis();
        dataTransfer.sendRequest(id, chain.request());
        try {
            Response response = chain.proceed(chain.request());
            dataTransfer.sendResponse(id, response);
            dataTransfer.sendDuration(id, System.currentTimeMillis() - startTime);
            return response;
        } catch (Exception e) {
            dataTransfer.sendException(id, e);
            dataTransfer.sendDuration(id, System.currentTimeMillis() - startTime);
            throw e;
        }
    }