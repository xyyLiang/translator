  private static int runSlashPreceding(String jsonish, int pos) {
    int startOfRun = pos;
    while (startOfRun >= 0 && jsonish.charAt(startOfRun) == '\\') {
      --startOfRun;
    }
    return pos - startOfRun;
  }