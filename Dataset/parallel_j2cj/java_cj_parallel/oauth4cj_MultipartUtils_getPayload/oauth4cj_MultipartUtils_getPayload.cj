    public static func getPayload(multipartPayload: MultipartPayload): ByteArrayStream {
        let os: ByteArrayStream = ByteArrayStream()

        let preamble: String = multipartPayload.getPreamble()
        if (!preamble.isEmpty()) {
            os.write((preamble + "\r\n").toArray())
        }
        let bodyParts: ArrayList<BodyPartPayload> = multipartPayload.getBodyParts()
        if (!bodyParts.isEmpty()) {
            let boundary: String = multipartPayload.getBoundary()
            let startBoundary: Array<UInt8> = ("--" + boundary + "\r\n").toArray()

            for (bodyPart in bodyParts) {
                os.write(startBoundary)

                let bodyPartHeaders: HashMap<String, String> = bodyPart.getHeaders()
                if (!bodyPartHeaders.isEmpty()) {
                    for ((k, v) in bodyPartHeaders) {
                        os.write((k + ": " + v + "\r\n").toArray())
                    }
                }

                os.write("\r\n".toArray())
                if (bodyPart is MultipartPayload) {
                    getPayload((bodyPart as MultipartPayload).getOrThrow()).copyTo(os)
                } else if (bodyPart is ByteArrayBodyPartPayload) {
                    let byteArrayBodyPart: ByteArrayBodyPartPayload =
                                            (bodyPart as ByteArrayBodyPartPayload).getOrThrow()
                    var buf: Array<UInt8> = byteArrayBodyPart.getPayload()
                    buf = buf.slice(byteArrayBodyPart.getOff(), byteArrayBodyPart.getLen())
                    os.write(buf)
                } else {
                    throw OAuth4cjException("the class type is not MultipartPayload and not ByteArrayBodyPartPayload.")
                }
                os.write("\r\n".toArray()) // CRLF for the next (starting or closing) boundary.
            }

            os.write(("--" + boundary + "--").toArray())
            let epilogue: String = multipartPayload.getEpilogue()
            if (!epilogue.isEmpty()) {
                os.write(("\r\n" + epilogue).toArray())
            }
        }
        return os
    }