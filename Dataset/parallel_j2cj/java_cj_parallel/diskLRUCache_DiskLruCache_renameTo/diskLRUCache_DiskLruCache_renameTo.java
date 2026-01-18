  private static void renameTo(File from, File to, boolean deleteDestination) throws IOException {
    if (deleteDestination) {
      deleteIfExists(to);
    }
    if (!from.renameTo(to)) {
      throw new IOException();
    }
  }
