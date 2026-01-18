    private void init() throws IOException {
        bsPutUByte('B');
        bsPutUByte('Z');

        this.data = new Data(this.blockSize100k);
        this.blockSorter = new BlockSort(this.data);

        // huffmanized magic bytes
        bsPutUByte('h');
        bsPutUByte('0' + this.blockSize100k);

        this.combinedCRC = 0;
        initBlock();
    }