    public override func translate(input: String, index: Int64, writer: Writer): Int64 {
        // check if translation exists for the input at position index
        if (prefixSet.contains(input.get(index) ?? '\0')) {
            var max = longest
            if (index + longest > input.size) {
                max = input.size - index
            }

            // implement greedy algorithm by trying maximum match first
            var i = max
            while (i >= shortest) {
                let subSeq = input.substring(index, i);
                if (lookupMap.contains(subSeq)) {
                    writer.write(lookupMap.get(subSeq) ?? "");
                    return subSeq.size;
                }
                i--
            }
        }

        return 0;
    }