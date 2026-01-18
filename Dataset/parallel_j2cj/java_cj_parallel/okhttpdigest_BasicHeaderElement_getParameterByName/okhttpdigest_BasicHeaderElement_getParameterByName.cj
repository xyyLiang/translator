    public func getParameterByName(name: String): BasicNameValuePair {
        if(name.isEmpty()) {
            throw IllegalArgumentException("Name may not be null")
        } else {
            var found: BasicNameValuePair = BasicNameValuePair(name,"")
            for (i in 0..this.parameters.size) {
                var current = this.parameters[i]
                if((current.getName().toLower()).equals(name.toLower())) {
                    found = current
                    break
                }
            }
            return found
        }
    }