    public FileNameUtil(final Map<String, String> uncompressSuffix, final String defaultExtension) {
        this.uncompressSuffix = Collections.unmodifiableMap(uncompressSuffix);
        int lc = Integer.MIN_VALUE, sc = Integer.MAX_VALUE;
        int lu = Integer.MIN_VALUE, su = Integer.MAX_VALUE;
        for (final Map.Entry<String, String> ent : uncompressSuffix.entrySet()) {
            final int cl = ent.getKey().length();
            if (cl > lc) {
                lc = cl;
            }
            if (cl < sc) {
                sc = cl;
            }

            final String u = ent.getValue();
            final int ul = u.length();
            if (ul > 0) {
                compressSuffix.computeIfAbsent(u, k -> ent.getKey());
                if (ul > lu) {
                    lu = ul;
                }
                if (ul < su) {
                    su = ul;
                }
            }
        }
        longestCompressedSuffix = lc;
        longestUncompressedSuffix = lu;
        shortestCompressedSuffix = sc;
        shortestUncompressedSuffix = su;
        this.defaultExtension = defaultExtension;
    }