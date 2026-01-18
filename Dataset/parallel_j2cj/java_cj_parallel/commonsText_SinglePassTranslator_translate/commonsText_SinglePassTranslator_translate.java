    @Override
    public int translate(final CharSequence input, final int index, final Writer writer) throws IOException {
        if (index != 0) {
            throw new IllegalArgumentException(getClassName() + ".translate(final CharSequence input, final int "
                    + "index, final Writer out) can not handle a non-zero index.");
        }

        translateWhole(input, writer);

        return Character.codePointCount(input, index, input.length());
    }