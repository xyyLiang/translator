    public void addBodyPart(MultipartPayload multipartPayload) {
        if (multipartPayload.getBoundary().equals(boundary)) {
            throw new IllegalArgumentException("{'boundary'}={'" + boundary
                    + "'} is the same for parent MultipartPayload and child");
        }
        bodyParts.add(multipartPayload);
    }