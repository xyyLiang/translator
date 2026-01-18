    public void cancel() {
        if (finished.get() || this.currentThread == null) return;

        currentThread.interrupt();
    }