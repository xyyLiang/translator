    public int readBodyData(OutputStream output)
            throws MalformedStreamException, IOException {
        return (int) Streams.copy(newInputStream(), output, false); // N.B. Streams.copy closes the input stream
    }