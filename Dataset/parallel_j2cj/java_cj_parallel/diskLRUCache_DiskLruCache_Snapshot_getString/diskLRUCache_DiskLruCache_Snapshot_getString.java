    public String getString(int index) throws IOException {
      return inputStreamToString(getInputStream(index));
    }