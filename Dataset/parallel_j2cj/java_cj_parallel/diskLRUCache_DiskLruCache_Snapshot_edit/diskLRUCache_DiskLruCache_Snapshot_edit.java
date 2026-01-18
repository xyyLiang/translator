    public Editor edit() throws IOException {
      return DiskLruCache.this.edit(key, sequenceNumber);
    }