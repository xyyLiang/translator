    public void toByteArray(byte[] array, int pos)
    {
        if (pos < 0 || (pos + 6) > array.length) {
            throw new IllegalArgumentException("Illegal offset ("+pos+"), need room for 6 bytes");
        }
        int i = (int) (_address >> 32);
        array[pos++] = (byte) (i >> 8);
        array[pos++] = (byte) i;
        i = (int) _address;
        array[pos++] = (byte) (i >> 24);
        array[pos++] = (byte) (i >> 16);
        array[pos++] = (byte) (i >> 8);
        array[pos] = (byte) i;
    }