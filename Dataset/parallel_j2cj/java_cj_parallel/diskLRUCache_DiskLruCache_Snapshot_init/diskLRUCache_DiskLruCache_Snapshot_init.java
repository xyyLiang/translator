    private Snapshot(String key, long sequenceNumber, InputStream[] ins, long[] lengths) {
      this.key = key;
      this.sequenceNumber = sequenceNumber;
      this.ins = ins;
      this.lengths = lengths;
    }

