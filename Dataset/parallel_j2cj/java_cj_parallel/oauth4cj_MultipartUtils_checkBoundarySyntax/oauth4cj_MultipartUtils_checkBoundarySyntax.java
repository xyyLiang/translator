    public static void checkBoundarySyntax(String boundary) {
        if (boundary == null || !BOUNDARY_REGEXP.matcher(boundary).matches()) {
            throw new IllegalArgumentException("{'boundary'='" + boundary + "'} has invalid syntax. Should be '"
                    + BOUNDARY_PATTERN + "'.");
        }
    }