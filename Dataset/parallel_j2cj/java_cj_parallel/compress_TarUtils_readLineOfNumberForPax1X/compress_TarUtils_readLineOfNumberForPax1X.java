    private static long[] readLineOfNumberForPax1X(final InputStream inputStream) throws IOException {
        int number;
        long result = 0;
        long bytesRead = 0;

        while ((number = inputStream.read()) != '\n') {
            bytesRead += 1;
            if (number == -1) {
                throw new IOException("Unexpected EOF when reading parse information of 1.X PAX format");
            }
            if (number < '0' || number > '9') {
                throw new IOException("Corrupted TAR archive. Non-numeric value in sparse headers block");
            }
            result = result * 10 + (number - '0');
        }
        bytesRead += 1;

        return new long[] { result, bytesRead };
    }