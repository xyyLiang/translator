    private func createDeviceAuthorization(rawResponse: String): DeviceAuthorization {

        let response: JsonObject = JsonValue.fromStr(rawResponse).asObject()

        let deviceCode: String = asStringGetValue(response, "device_code", rawResponse)
        let userCode: String = asStringGetValue(response, "user_code", rawResponse)
        let verificationUri: String = asStringGetValue(response, getVerificationUriParamName(), rawResponse)
        let expiresIn: JsonValue = extractRequiredParameter(response, "expires_in", rawResponse)
        var expiresInSeconds: Int64 = 0
        try {
            expiresInSeconds = expiresIn.asInt().getValue()
        } catch (ex: Exception) {
            expiresInSeconds = 0
        }

        let deviceAuthorization: DeviceAuthorization =
                    DeviceAuthorization(deviceCode, userCode, verificationUri, expiresInSeconds)

        if (response.containsKey("interval")) {
            let intervalJsonValue: JsonValue = response.get("interval").getOrThrow()
            deviceAuthorization.setIntervalSeconds(asIntOfJsonValue(intervalJsonValue, 5))
        }

        if (response.containsKey("verification_uri_complete")) {
            let verificationUriCompleteJsonValue: JsonValue = response.get("verification_uri_complete").getOrThrow()
            let verificationUriComplete: String = asTextOfJsonValue(verificationUriCompleteJsonValue)
            deviceAuthorization.setVerificationUriComplete(verificationUriComplete)
        }

        return deviceAuthorization
    }