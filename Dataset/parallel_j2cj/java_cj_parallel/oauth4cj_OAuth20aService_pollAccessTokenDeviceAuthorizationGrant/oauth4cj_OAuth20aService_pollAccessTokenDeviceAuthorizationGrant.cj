    public func pollAccessTokenDeviceAuthorizationGrant(deviceAuthorization: DeviceAuthorization): OAuth2AccessToken {
        var intervalMillis: Int64 = Int64(deviceAuthorization.getIntervalSeconds()) * 1000
        while (true) {
            try {
                return getAccessTokenDeviceAuthorizationGrant(deviceAuthorization)
            } catch (e: OAuth2AccessTokenErrorResponseException) {
                var err: String = ""
                var flag: Bool = false
                let error: Option<OAuth2Error> = e.getError()
                match(error) {
                    case Some(v) =>
                            err = v.getErrorString()
                            flag = true
                    case None => ()
                }

                if (flag && err != OAuth2Error.AUTHORIZATION_PENDING.getErrorString()) {
                    if (flag && err == OAuth2Error.SLOW_DOWN.getErrorString()) {
                        intervalMillis += 5000
                    } else {
                        throw e
                    }
                }
            }
            sleep(intervalMillis * Duration.nanosecond)
        }
        return OAuth2AccessToken("")
    }