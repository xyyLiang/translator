    public void close() {
      for (InputStream in : ins) {
        Util.closeQuietly(in);
      }
    }