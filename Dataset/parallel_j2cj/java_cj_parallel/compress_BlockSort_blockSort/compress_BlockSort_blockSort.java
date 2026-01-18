    void blockSort(final BZip2CompressorOutputStream.Data data, final int last) {
        this.workLimit = WORK_FACTOR * last;
        this.workDone = 0;
        this.firstAttempt = true;

        if (last + 1 < 10000) {
            fallbackSort(data, last);
        } else {
            mainSort(data, last);

            if (this.firstAttempt && this.workDone > this.workLimit) {
                fallbackSort(data, last);
            }
        }

        final int[] fmap = data.fmap;
        data.origPtr = -1;
        for (int i = 0; i <= last; i++) {
            if (fmap[i] == 0) {
                data.origPtr = i;
                break;
            }
        }

        // assert (data.origPtr != -1) : data.origPtr;
    }