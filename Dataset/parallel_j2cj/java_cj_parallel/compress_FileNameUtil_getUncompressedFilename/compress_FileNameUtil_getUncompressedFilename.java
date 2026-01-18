    public String getUncompressedFileName(final String fileName) {
        final String lower = fileName.toLowerCase(Locale.ENGLISH);
        final int n = lower.length();
        for (int i = shortestCompressedSuffix; i <= longestCompressedSuffix && i < n; i++) {
            final String suffix = uncompressSuffix.get(lower.substring(n - i));
            if (suffix != null) {
                return fileName.substring(0, n - i) + suffix;
            }
        }
        return fileName;
    }