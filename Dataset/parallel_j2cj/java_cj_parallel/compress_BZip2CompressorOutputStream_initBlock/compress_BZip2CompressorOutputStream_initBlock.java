    private void initBlock() {
        // blockNo++;
        this.crc.reset();
        this.last = -1;
        // ch = 0;

        final boolean[] inUse = this.data.inUse;
        for (int i = 256; --i >= 0;) {
            inUse[i] = false;
        }

    }