    void fallbackSort(final BZip2CompressorOutputStream.Data data, final int last) {
        data.block[0] = data.block[last + 1];
        fallbackSort(data.fmap, data.block, last + 1);
        for (int i = 0; i < last + 1; i++) {
            --data.fmap[i];
        }
        for (int i = 0; i < last + 1; i++) {
            if (data.fmap[i] == -1) {
                data.fmap[i] = last;
                break;
            }
        }
    }