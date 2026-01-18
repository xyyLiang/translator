    private static int med3(final int a, final int b, final int c) {
        return a < b ? b < c ? b : a < c ? c : a : b > c ? b : a > c ? c : a;
    }