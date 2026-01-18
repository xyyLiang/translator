    public static String wrapText(String line, int columnWidth) {
        if (columnWidth < 0) {
            throw new IllegalArgumentException("columnWidth may not be less 0");
        }
        if (columnWidth == 0) {
            return line;
        }
        int length = line.length();
        int delimiter = "<br/>".length();
        int widthIndex = columnWidth;

        StringBuilder b = new StringBuilder(line);

        for (int count = 0; length > widthIndex; count++) {
            int breakPoint = widthIndex + delimiter * count;
            if (Character.isHighSurrogate(b.charAt(breakPoint - 1)) &&
                Character.isLowSurrogate(b.charAt(breakPoint))) {
              // Shift a breakpoint that would split a supplemental code-point.
              breakPoint += 1;
              if (breakPoint == b.length()) {
                // Break before instead of after if this is the last code-point.
                breakPoint -= 2;
              }
            }
            b.insert(breakPoint, "<br/>");
            widthIndex += columnWidth;
        }

        return b.toString();
    }