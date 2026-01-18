    private Snake buildSnake(final int start, final int diag, final int end1, final int end2) {
        int end = start;
        while (end - diag < end2
                && end < end1
                && left.charAt(end) == right.charAt(end - diag)) {
            ++end;
        }
        return new Snake(start, end, diag);
    }