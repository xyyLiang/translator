    protected override func translateWhole(input: String, writer: Writer): Unit {
        if (containsNone(input, CSV_SEARCH_CHARS)) {
            writer.write(input);
        } else {
            // input needs quoting
            writer.write(CSV_QUOTE);
            writer.write(input.replace(CSV_QUOTE_STR, CSV_ESCAPED_QUOTE_STR));
            writer.write(CSV_QUOTE);
        }
    }