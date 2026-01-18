    public init(rawResponse: OAuth4cjResponse) {
        super(rawResponse.getBody())
        this.response = rawResponse
    }