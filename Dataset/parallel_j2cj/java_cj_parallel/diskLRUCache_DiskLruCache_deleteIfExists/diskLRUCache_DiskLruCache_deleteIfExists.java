  private static void deleteIfExists(File file) throws IOException {
    if (file.exists() && !file.delete()) {
      throw new IOException();
    }
  }
