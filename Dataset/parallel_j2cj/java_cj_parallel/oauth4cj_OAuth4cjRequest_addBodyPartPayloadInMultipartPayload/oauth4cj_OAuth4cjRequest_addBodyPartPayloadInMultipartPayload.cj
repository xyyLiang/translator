    public func addBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload): Unit {
        match (multipartPayload) {
            case Some(payload) => payload.addBodyPart(bodyPartPayload)
            case None =>
                initMultipartPayload()
                multipartPayload.getOrThrow().addBodyPart(bodyPartPayload)
        }
    }