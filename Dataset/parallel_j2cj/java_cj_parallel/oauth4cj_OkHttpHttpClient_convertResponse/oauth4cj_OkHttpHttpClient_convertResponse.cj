    static func convertResponse(okHttpResponse: httpclient4cj.Response): OAuth4cjResponse {
        let headers: Header = okHttpResponse.getHeaders()
        let headersMap: HashMap<String, String> = HashMap<String, String>()
        for ((k, v) in headers) {
            headersMap.put(k, v[0])
        }

        let body: ResponseBody = okHttpResponse.getBody().getOrThrow()

        let source: Source = body.getSource()
        let bodyStream: ByteArrayStream = ByteArrayStream(4096)
        try (r = source) {
            while (source.read(bodyStream, 4096) > 0) {}
        } catch (e: EOFException) {}

        let closeables: ArrayList<Resource> = ArrayList<Resource>()
        closeables.append(source)
        closeables.append(body)
        return OAuth4cjResponse(Int32(okHttpResponse.getCode()), okHttpResponse.getMessage(),
                headersMap, bodyStream, closeables)
    }