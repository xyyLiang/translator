
    private Response doExecute(String userAgent, Map<String, String> headers, Verb httpVerb, String completeUrl,
            BodyType bodyType, Object bodyContents) throws IOException {
        final Call call = createCall(userAgent, headers, httpVerb, completeUrl, bodyType, bodyContents);
        return convertResponse(call.execute());
    }