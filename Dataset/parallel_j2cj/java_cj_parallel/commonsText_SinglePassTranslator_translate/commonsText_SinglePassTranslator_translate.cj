    public override func translate(input: String, index: Int64, writer: Writer): Int64 {
        if (index != 0) {
            throw IllegalArgumentException(
                getClassName() + ".translate(input: String, index: Int64, writer: Writer) can not handle a non-zero index."
            );
        }

        translateWhole(input, writer);

        return input.size;
    }