    public File getDirtyFile(int i) {
      return new File(directory, key + "." + i + ".tmp");
    }