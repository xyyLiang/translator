    @Override
    public boolean translate(final int codePoint, final Writer writer) throws IOException {
        if (between) {
            if (codePoint < below || codePoint > above) {
                return false;
            }
        } else if (codePoint >= below && codePoint <= above) {
            return false;
        }

        if (codePoint > 0xffff) {
            writer.write(toUtf16Escape(codePoint));
        } else {
          writer.write("\\u");
          writer.write(HEX_DIGITS[codePoint >> 12 & 15]);
          writer.write(HEX_DIGITS[codePoint >> 8 & 15]);
          writer.write(HEX_DIGITS[codePoint >> 4 & 15]);
          writer.write(HEX_DIGITS[codePoint & 15]);
        }
        return true;
    }