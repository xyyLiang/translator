        @Override
        void translateWhole(final CharSequence input, final Writer writer) throws IOException {
            final String inputSting = input.toString();
            if (StringUtils.containsNone(inputSting, CSV_SEARCH_CHARS)) {
                writer.write(inputSting);
            } else {
                // input needs quoting
                writer.write(CSV_QUOTE);
                writer.write(StringUtils.replace(inputSting, CSV_QUOTE_STR, CSV_ESCAPED_QUOTE_STR));
                writer.write(CSV_QUOTE);
            }
        }