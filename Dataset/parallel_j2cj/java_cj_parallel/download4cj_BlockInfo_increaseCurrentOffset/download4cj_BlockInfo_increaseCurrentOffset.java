    public void increaseCurrentOffset(@IntRange(from = 1) long increaseLength) {
        this.currentOffset.addAndGet(increaseLength);
    }