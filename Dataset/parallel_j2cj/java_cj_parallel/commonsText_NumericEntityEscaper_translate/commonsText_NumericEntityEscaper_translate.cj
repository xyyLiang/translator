    public func translate(codePoint: Char, writer: Writer): Bool {
        writer.write("&#");
        writer.write(UInt32(codePoint));
        writer.write(';');
        return true;
    }