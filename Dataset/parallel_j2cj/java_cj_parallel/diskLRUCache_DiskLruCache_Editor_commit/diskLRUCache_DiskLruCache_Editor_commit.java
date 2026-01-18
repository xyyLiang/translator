    public void commit() throws IOException {
      if (hasErrors) {
        completeEdit(this, false);
        remove(entry.key); // The previous entry is stale.
      } else {
        completeEdit(this, true);
      }
      committed = true;
    }

