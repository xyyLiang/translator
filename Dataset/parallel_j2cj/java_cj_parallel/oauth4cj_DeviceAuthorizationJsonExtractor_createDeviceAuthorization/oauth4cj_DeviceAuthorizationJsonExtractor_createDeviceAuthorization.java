    private DeviceAuthorization createDeviceAuthorization(String rawResponse) throws IOException {

        final JsonNode response = OBJECT_MAPPER.readTree(rawResponse);

        final DeviceAuthorization deviceAuthorization = new DeviceAuthorization(
                extractRequiredParameter(response, "device_code", rawResponse).textValue(),
                extractRequiredParameter(response, "user_code", rawResponse).textValue(),
                extractRequiredParameter(response, getVerificationUriParamName(), rawResponse).textValue(),
                extractRequiredParameter(response, "expires_in", rawResponse).intValue());

        final JsonNode intervalSeconds = response.get("interval");
        if (intervalSeconds != null) {
            deviceAuthorization.setIntervalSeconds(intervalSeconds.asInt(5));
        }

        final JsonNode verificationUriComplete = response.get("verification_uri_complete");
        if (verificationUriComplete != null) {
            deviceAuthorization.setVerificationUriComplete(verificationUriComplete.asText());
        }

        return deviceAuthorization;
    }
