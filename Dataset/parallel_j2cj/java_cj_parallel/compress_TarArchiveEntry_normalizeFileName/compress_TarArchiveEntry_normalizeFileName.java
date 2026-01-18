    private static String normalizeFileName(String fileName, final boolean preserveAbsolutePath) {
        if (!preserveAbsolutePath) {
            final String property = System.getProperty("os.name");
            if (property != null) {
                final String osName = property.toLowerCase(Locale.ROOT);

                // Strip off drive letters!
                // REVIEW Would a better check be "(File.separator == '\')"?

                if (osName.startsWith("windows")) {
                    if (fileName.length() > 2) {
                        final char ch1 = fileName.charAt(0);
                        final char ch2 = fileName.charAt(1);

                        if (ch2 == ':' && (ch1 >= 'a' && ch1 <= 'z' || ch1 >= 'A' && ch1 <= 'Z')) {
                            fileName = fileName.substring(2);
                        }
                    }
                } else if (osName.contains("netware")) {
                    final int colon = fileName.indexOf(':');
                    if (colon != -1) {
                        fileName = fileName.substring(colon + 1);
                    }
                }
            }
        }