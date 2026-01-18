        @Override
        public int translate(final CharSequence input, final int index, final Writer writer) throws IOException {

            if (index != 0) {
                throw new IllegalStateException("XsiUnescaper should never reach the [1] index");
            }

            final String s = input.toString();

            int segmentStart = 0;
            int searchOffset = 0;
            while (true) {
                final int pos = s.indexOf(BACKSLASH, searchOffset);
                if (pos == -1) {
                    if (segmentStart < s.length()) {
                        writer.write(s.substring(segmentStart));
                    }
                    break;
                }
                if (pos > segmentStart) {
                    writer.write(s.substring(segmentStart, pos));
                }
                segmentStart = pos + 1;
                searchOffset = pos + 2;
            }

            return Character.codePointCount(input, 0, input.length());
        }