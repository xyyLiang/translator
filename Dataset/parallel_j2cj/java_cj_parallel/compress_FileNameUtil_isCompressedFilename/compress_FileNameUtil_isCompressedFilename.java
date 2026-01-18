    public boolean isCompressedFileName(final String fileName) {
        final String lower = fileName.toLowerCase(Locale.ENGLISH);
        final int n = lower.length();
        for (int i = shortestCompressedSuffix; i <= longestCompressedSuffix && i < n; i++) {
            if (uncompressSuffix.containsKey(lower.substring(n - i))) {
                return true;
            }
        }
        return false;
    }