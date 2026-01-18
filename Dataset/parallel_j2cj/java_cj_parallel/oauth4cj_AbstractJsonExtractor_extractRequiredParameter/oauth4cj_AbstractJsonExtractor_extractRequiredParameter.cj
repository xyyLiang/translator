    protected static func extractRequiredParameter(errorNode: JsonObject, parameterName: String,
                                                    rawResponse: String): JsonValue  {
        var parameterNames: String = parameterName

        var value: JsonValue = errorNode
        var flag: Bool = errorNode.containsKey(parameterNames)

        if (!flag && (parameterNames == "expires_in")) {//for huawei
            parameterNames = "expire_in"
            flag = errorNode.containsKey(parameterNames)
        } else if (!flag && (parameterNames == "verification_uri")) {//for huawei
            parameterNames = "verification_url"
            flag = errorNode.containsKey(parameterNames)
        }

        if (flag) {
            value = errorNode.get(parameterNames).getOrThrow()
        } else {
            let err: String =
                "Response body is incorrect. Can't extract a '${parameterNames}' from this: '${rawResponse}'"
            throw OAuth4cjException(err)
        }

        return value
    }