    private func createCall(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyType: BodyType, bodyContents: Any): Call {
        let requestBuilder: RequestBuilder = Request.builder()
        requestBuilder.url(completeUrl)

        let method: String = httpVerb.toString()

        var body: Option<RequestBody> = None
        if (httpVerb.isPermitBody()) {
            var mediaType: Option<MediaType> = DEFAULT_CONTENT_TYPE_MEDIA_TYPE
            if (headers.contains(OAuthConstants.CONTENT_TYPE)) {
                mediaType = MediaType.parse(headers[OAuthConstants.CONTENT_TYPE])
            }

            body = bodyType.createBody(mediaType, bodyContents)
        }

        //fill HTTP method and body to RequestBuilder.
        requestBuilder.method(method, body: body)

        //fill headers to RequestBuilder.
        for ((k, v) in headers) {
            requestBuilder.header(k, v)
        }

        requestBuilder.header(OAuthConstants.USER_AGENT_HEADER_NAME, userAgent)

        //create a new call.
        return client.newCall(requestBuilder.build())
    }