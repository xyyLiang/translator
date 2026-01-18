    public func execute():DownloadConnectionConnected{
        request = requestBuilder.build()
        response = client.newCall(request.getOrThrow()).execute()
        return this
    }
