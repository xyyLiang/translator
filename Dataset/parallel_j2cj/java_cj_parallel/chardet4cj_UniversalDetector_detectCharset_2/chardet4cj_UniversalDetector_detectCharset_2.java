    public static String detectCharset(InputStream inputStream) throws IOException {
        byte[] buf = new byte[4096];

        UniversalDetector detector = new UniversalDetector(null);

        int nread;
        while ((nread = inputStream.read(buf)) > 0 && !detector.isDone()) {
            detector.handleData(buf, 0, nread);
        }
        detector.dataEnd();

        String encoding = detector.getDetectedCharset();
        detector.reset();
        return encoding;
    }