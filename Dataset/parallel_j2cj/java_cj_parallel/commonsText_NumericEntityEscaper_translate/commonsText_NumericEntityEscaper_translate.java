    @Override
    public boolean translate(final int codePoint, final Writer writer) throws IOException {
        if (this.between != this.range.contains(codePoint)) {
            return false;
        }
        writer.write("&#");
        writer.write(Integer.toString(codePoint, 10));
        writer.write(';');
        return true;
    }