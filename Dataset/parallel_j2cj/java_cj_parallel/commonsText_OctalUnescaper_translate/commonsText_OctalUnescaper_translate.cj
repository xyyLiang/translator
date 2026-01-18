    public override func translate(input: String, index: Int64, writer: Writer): Int64 {
        let remaining = input.size - index - 1 // how many characters left, ignoring the first \

        if (input[index] == '\\' && remaining > 0 && isOctalDigit(input[index + 1])) {
            let builder = StringBuilder()
            let next = index + 1
            let next2 = index + 2
            let next3 = index + 3

            builder.append("0O"); // add a leading 0O to avoid octal confusion

            // we know this is good as we checked it in the if block above
            builder.append(input[next])

            if (remaining > 1 && isOctalDigit(input[next2])) {
                builder.append(input[next2])
                if (remaining > 2 && isZeroToThree(input[next]) && isOctalDigit(input[next3])) {
                    builder.append(input[next3])
                }
            }

            writer.write(Char(Int32.parse(builder.toString())))
            return 1 + builder.size - 2 // +1 for the first \, -2 for the 0O
        }
        return 0;
    }