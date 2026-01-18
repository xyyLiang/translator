    public override func translate(codePoint: Char, writer: Writer): Bool {
        if (codePoint > Char(0xffff)) {
            writer.write(toUtf16Escape(codePoint));
        } else {
            writer.write("\\u");
            writer.write(hex(UInt32(codePoint)));
        }

        return true;
    }