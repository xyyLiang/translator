    private void initBlock() throws IOException {
        final BitInputStream bin = this.bin;
        char magic0;
        char magic1;
        char magic2;
        char magic3;
        char magic4;
        char magic5;

        while (true) {
            // Get the block magic bytes.
            magic0 = bsGetUByte(bin);
            magic1 = bsGetUByte(bin);
            magic2 = bsGetUByte(bin);
            magic3 = bsGetUByte(bin);
            magic4 = bsGetUByte(bin);
            magic5 = bsGetUByte(bin);

            // If isn't end of stream magic, break out of the loop.
            if (magic0 != 0x17 || magic1 != 0x72 || magic2 != 0x45 || magic3 != 0x38 || magic4 != 0x50 || magic5 != 0x90) {
                break;
            }

            // End of stream was reached. Check the combined CRC and
            // advance to the next .bz2 stream if decoding concatenated
            // streams.
            if (complete()) {
                return;
            }
        }

        if (magic0 != 0x31 || // '1'
                magic1 != 0x41 || // ')'
                magic2 != 0x59 || // 'Y'
                magic3 != 0x26 || // '&'
                magic4 != 0x53 || // 'S'
                magic5 != 0x59 // 'Y'
        ) {
            this.currentState = EOF;
            throw new IOException("Bad block header");
        }
        this.storedBlockCRC = bsGetInt(bin);
        this.blockRandomised = bsR(bin, 1) == 1;

        /*
         * Allocate data here instead in constructor, so we do not allocate it if the input file is empty.
         */
        if (this.data == null) {
            this.data = new Data(this.blockSize100k);
        }

        // currBlockNo++;
        getAndMoveToFrontDecode();

        this.crc.reset();
        this.currentState = START_BLOCK_STATE;
    }
