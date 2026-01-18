    protected func getSortedAndEncodedParams(request: OAuth4cjRequest): String {
        let params: ParameterList = ParameterList()
        params.addAll(request.getQueryStringParams())
        params.addAll(request.getBodyParams())
        params.addAll(ParameterList(request.getOauthParameters()))
        return params.sort().asOauthBaseString()
    }