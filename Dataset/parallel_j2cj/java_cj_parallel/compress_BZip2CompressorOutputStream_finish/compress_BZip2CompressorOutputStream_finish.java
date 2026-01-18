    public void finish() throws IOException {
        if (!closed) {
            closed = true;
            try {
                if (this.runLength > 0) {
                    writeRun();
                }
                this.currentChar = -1;
                endBlock();
                endCompression();
            } finally {
                this.out = null;
                this.blockSorter = null;
                this.data = null;
            }
        }    @Override
    public void flush() throws IOException {
        final OutputStream outShadow = this.out;
        if (outShadow != null) {
            outShadow.flush();
        }
    }
    }