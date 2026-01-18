    @Override
    public int translate(final CharSequence input, final int index, final Writer writer) throws IOException {
        // check if translation exists for the input at position index
        if (prefixSet.get(input.charAt(index))) {
            int max = longest;
            if (index + longest > input.length()) {
                max = input.length() - index;
            }
            // implement greedy algorithm by trying maximum match first
            for (int i = max; i >= shortest; i--) {
                final CharSequence subSeq = input.subSequence(index, index + i);
                final String result = lookupMap.get(subSeq.toString());

                if (result != null) {
                    writer.write(result);
                    return Character.codePointCount(subSeq, 0, subSeq.length());
                }
            }
        }
        return 0;
    }