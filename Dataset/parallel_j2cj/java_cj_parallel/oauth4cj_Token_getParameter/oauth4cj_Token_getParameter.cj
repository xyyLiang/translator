    public func getParameter(parameter: String): String {
        var value:String = ""
        var valueArray:Array<String> = rawResponse.split("&")

        for (str in valueArray) {
            if (str.startsWith("${parameter}=")) {
                let paramArray:Array<String> = str.split("=")
                if (paramArray.size > 1) {
                    value = paramArray[1].trim()
                }
                break
            }
        }
        return value
    }