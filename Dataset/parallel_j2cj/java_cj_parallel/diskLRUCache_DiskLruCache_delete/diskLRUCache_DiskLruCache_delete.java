  public void delete() throws IOException {
    close();
    Util.deleteContents(directory);
  }
