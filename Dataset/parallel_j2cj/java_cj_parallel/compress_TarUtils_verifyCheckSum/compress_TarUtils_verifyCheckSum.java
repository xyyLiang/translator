    public static boolean verifyCheckSum(final byte[] header) {
        final long storedSum = parseOctal(header, TarConstants.CHKSUM_OFFSET, TarConstants.CHKSUMLEN);
        long unsignedSum = 0;
        long signedSum = 0;

        for (int i = 0; i < header.length; i++) {
            byte b = header[i];
            if (TarConstants.CHKSUM_OFFSET <= i && i < TarConstants.CHKSUM_OFFSET + TarConstants.CHKSUMLEN) {
                b = ' ';
            }
            unsignedSum += 0xff & b;
            signedSum += b;
        }
        return storedSum == unsignedSum || storedSum == signedSum;
    }