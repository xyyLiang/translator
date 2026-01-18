    public init(name: String, value: String, parameters: ArrayList<BasicNameValuePair>) {
        this.name = name
        this.value = value
        if(!parameters.isEmpty()) {
            this.parameters = parameters
        } else {
            this.parameters = ArrayList<BasicNameValuePair>()
        }


    }