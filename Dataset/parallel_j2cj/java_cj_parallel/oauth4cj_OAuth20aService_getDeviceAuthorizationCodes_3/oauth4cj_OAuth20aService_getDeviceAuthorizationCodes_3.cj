    public func getDeviceAuthorizationCodes(scope: Option<String>,
            callback: Option<OAuthAsyncRequestCallback>): Future<DeviceAuthorization> {
        let request: OAuth4cjRequest = createDeviceAuthorizationCodesRequest(scope)

        let rc: ResponseConverterDeviceAuthorization = ResponseConverterDeviceAuthorization(api)
        let res: Future<Any> = execute(request, callback, Some(rc))

        let nowFuture: Future<DeviceAuthorization> = spawn {
            let result = res.get()
            let deviceAuthorization: Option<DeviceAuthorization> = result as DeviceAuthorization
            match(deviceAuthorization) {
                case Some(v) => return v
                case None =>
                    let err: String = "Exception in parsing DeviceAuthorization, response is: ${rc.responseString}"
                    let ex: Exception = (result as Exception) ?? OAuth4cjException(err)
                    throw OAuth4cjException(ex.message)
            }
        }
        return nowFuture
    }