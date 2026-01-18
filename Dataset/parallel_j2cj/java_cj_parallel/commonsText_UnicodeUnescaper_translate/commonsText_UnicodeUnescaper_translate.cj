    public override func translate(input: String, index: Int64, writer: Writer): Int64 {
        if (input.get(index) == '\\' && index + 1 < input.size && input.get(index + 1) == 'u') {
            // consume optional additional 'u' chars
            var i = 2
            while (index + i < input.size && input.get(index + i) == 'u') {
                i++
            }
            if (index + i < input.size && input.get(index + i) == '+') {
                i++
            }
            if (index + i + 4 <= input.size) {
                // Get 4 hex digits
                let unicode = input.substring(index + i, 4)
                let value = Int32.parse("0x" + unicode);

                // UCS2 Surrogate Code Points
                if (value >= 0xD800i32 && value <= 0xDC00i32) {
                    if (index + i + 6 < input.size && input.get(index + i + 4) == '\\' && input.get(index + i + 5) == 'u') {
                        let unicode2 = input.substring(index + i + 6, 4)
                        let value2 = Int32.parse("0x" + unicode2);
                        if (value2 >= 0xDC00i32 && value2 <= 0xDFFFi32) {
                            let utf32 = utf16ToUtf32(value, value2)
                            writer.write(Char(utf32));
                            return i + 10
                        }
                    }
                } else {
                    writer.write(Char(value))
                    return i + 4
                }
            }
            throw IllegalArgumentException(
                "Less than 4 hex digits in unicode value: '" + input.substring(index, input.size - index) +
                    "' due to end of CharSequence"
            )
        }
        return 0;
    }