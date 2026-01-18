    public String getCompressedFileName(final String fileName) {
        final String lower = fileName.toLowerCase(Locale.ENGLISH);
        final int n = lower.length();
        for (int i = shortestUncompressedSuffix; i <= longestUncompressedSuffix && i < n; i++) {
            final String suffix = compressSuffix.get(lower.substring(n - i));
            if (suffix != null) {
                return fileName.substring(0, n - i) + suffix;
            }
        }
        // No custom suffix found, just append the default
        return fileName + defaultExtension;
    }