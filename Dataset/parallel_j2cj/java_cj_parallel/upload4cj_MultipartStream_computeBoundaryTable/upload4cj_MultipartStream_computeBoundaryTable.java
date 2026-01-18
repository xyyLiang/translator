    private void computeBoundaryTable() {
        int position = 2;
        int candidate = 0;

        boundaryTable[0] = -1;
        boundaryTable[1] = 0;

        while (position <= boundaryLength) {
            if (boundary[position - 1] == boundary[candidate]) {
                boundaryTable[position] = candidate + 1;
                candidate++;
                position++;
            } else if (candidate > 0) {
                candidate = boundaryTable[candidate];
            } else {
                boundaryTable[position] = 0;
                position++;
            }
        }
    }