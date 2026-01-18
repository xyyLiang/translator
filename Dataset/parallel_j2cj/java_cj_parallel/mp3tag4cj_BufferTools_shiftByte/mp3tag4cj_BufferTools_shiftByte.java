public static int shiftByte(byte c, int places) {
    int i = c & 0xff;
    if (places < 0) {
        return i << -places;
    } else if (places > 0) {
        return i >> places;
    }
    return i;
}