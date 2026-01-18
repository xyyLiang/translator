    public OutputStream newOutputStream(int index) throws IOException {
      if (index < 0 || index >= valueCount) {
        throw new IllegalArgumentException("Expected index " + index + " to "
                + "be greater than 0 and less than the maximum value count "
                + "of " + valueCount);
      }
      synchronized (DiskLruCache.this) {
        if (entry.currentEditor != this) {
          throw new IllegalStateException();
        }
        if (!entry.readable) {
          written[index] = true;
        }
        File dirtyFile = entry.getDirtyFile(index);
        FileOutputStream outputStream;
        try {
          outputStream = new FileOutputStream(dirtyFile);
        } catch (FileNotFoundException e) {
          // Attempt to recreate the cache directory.
          directory.mkdirs();
          try {
            outputStream = new FileOutputStream(dirtyFile);
          } catch (FileNotFoundException e2) {
            // We are unable to recover. Silently eat the writes.
            return NULL_OUTPUT_STREAM;
          }
        }
        return new FaultHidingOutputStream(outputStream);
      }
    }
