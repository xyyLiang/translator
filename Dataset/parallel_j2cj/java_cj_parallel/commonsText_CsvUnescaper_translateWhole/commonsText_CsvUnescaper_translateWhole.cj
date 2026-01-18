    protected override func translateWhole(input: String, writer: Writer): Unit {
        // is input not quoted?
        if (input.get(0) != CSV_QUOTE || input.get(input.size - 1) != CSV_QUOTE) {
            writer.write(input);
            return;
        }

        // strip quotes
        let quoteless = input.substring(1, input.size - 2);

        if (containsAny(quoteless, CSV_SEARCH_CHARS)) {
            // deal with escaped quotes; ie) ""
            writer.write(quoteless.replace(CSV_ESCAPED_QUOTE_STR, CSV_QUOTE_STR));
        } else {
            writer.write(quoteless);
        }
    }