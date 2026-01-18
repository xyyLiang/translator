    public func convertResponse(response: okhttp.Response): String {
        var bytes: Array<Byte> = Array<Byte>()
        let f: File = convert.convertResponse(response)
        response.close()
        f.read(bytes)
        return bytes.toString()
    }