    public func addBodyPart(multipartPayload: MultipartPayload): Unit {
        if (multipartPayload.getBoundary() == boundary) {
            let err: String = "{'boundary'}={'" + boundary + "'} is the same for parent MultipartPayload and child."
            throw IllegalArgumentException(err)
        }
        bodyParts.append(multipartPayload)
    }