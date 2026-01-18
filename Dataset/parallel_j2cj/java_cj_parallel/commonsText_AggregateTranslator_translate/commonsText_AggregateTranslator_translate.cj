    public func translate(input: String, index: Int64, writer: Writer): Int64 {
        for (translator in translators) {
            let consumed = translator.translate(input, index, writer);
            if (consumed != 0) {
                return consumed
            }
        }
        return 0;
    }