    public func getByteArrayPayload(): Array<UInt8> {
        if (byteArrayPayload.size != 0) {
            return byteArrayPayload
        }
        let body: String = bodyParams.asFormUrlEncodedString()
        return body.toArray()
    }