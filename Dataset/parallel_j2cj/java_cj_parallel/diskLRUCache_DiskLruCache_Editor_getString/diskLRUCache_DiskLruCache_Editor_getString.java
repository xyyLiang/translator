    public String getString(int index) throws IOException {
      InputStream in = newInputStream(index);
      return in != null ? inputStreamToString(in) : null;
    }