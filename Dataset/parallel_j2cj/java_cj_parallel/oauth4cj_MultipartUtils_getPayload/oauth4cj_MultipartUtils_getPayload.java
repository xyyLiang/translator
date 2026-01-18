    public static ByteArrayOutputStream getPayload(MultipartPayload multipartPayload) throws IOException {
        final ByteArrayOutputStream os = new ByteArrayOutputStream();

        final String preamble = multipartPayload.getPreamble();
        if (preamble != null) {
            os.write((preamble + "\r\n").getBytes());
        }
        final List<BodyPartPayload> bodyParts = multipartPayload.getBodyParts();
        if (!bodyParts.isEmpty()) {
            final String boundary = multipartPayload.getBoundary();
            final byte[] startBoundary = ("--" + boundary + "\r\n").getBytes();

            for (BodyPartPayload bodyPart : bodyParts) {
                os.write(startBoundary);

                final Map<String, String> bodyPartHeaders = bodyPart.getHeaders();
                if (bodyPartHeaders != null) {
                    for (Map.Entry<String, String> header : bodyPartHeaders.entrySet()) {
                        os.write((header.getKey() + ": " + header.getValue() + "\r\n").getBytes());
                    }
                }

                os.write("\r\n".getBytes());
                if (bodyPart instanceof MultipartPayload) {
                    getPayload((MultipartPayload) bodyPart).writeTo(os);
                } else if (bodyPart instanceof ByteArrayBodyPartPayload) {
                    final ByteArrayBodyPartPayload byteArrayBodyPart = (ByteArrayBodyPartPayload) bodyPart;
                    os.write(byteArrayBodyPart.getPayload(), byteArrayBodyPart.getOff(), byteArrayBodyPart.getLen());
                } else {
                    throw new AssertionError(bodyPart.getClass());
                }
                os.write("\r\n".getBytes()); //CRLF for the next (starting or closing) boundary
            }

            os.write(("--" + boundary + "--").getBytes());
            final String epilogue = multipartPayload.getEpilogue();
            if (epilogue != null) {
                os.write(("\r\n" + epilogue).getBytes());
            }

        }
        return os;
    }