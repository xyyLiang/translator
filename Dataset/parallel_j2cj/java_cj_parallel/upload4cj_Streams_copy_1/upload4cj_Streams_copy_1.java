    public static long copy(InputStream inputStream,
            OutputStream outputStream, boolean closeOutputStream,
            byte[] buffer)
    throws IOException {
        OutputStream out = outputStream;
        InputStream in = inputStream;
        try {
            long total = 0;
            for (;;) {
                int res = in.read(buffer);
                if (res <= 0) {
                    break;
                }
                if (res > 0) {
                    total += res;
                    if (out != null) {
                        out.write(buffer, 0, res);
                    }
                }
            }
            if (out != null) {
                if (closeOutputStream) {
                    out.close();
                } else {
                    out.flush();
                }
                out = null;
            }
            in.close();
            in = null;
            return total;
        } finally {
            IOUtils.closeQuietly(in);
            if (closeOutputStream) {
                IOUtils.closeQuietly(out);
            }
        }
    }
