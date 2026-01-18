    public void toByteArray(byte[] array) {
        if (array.length < 6) {
            throw new IllegalArgumentException("Too small array, need to have space for 6 bytes");
        }
        toByteArray(array, 0);
    }