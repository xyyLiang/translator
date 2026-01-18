            @Override
            public InputStream openStream() throws IOException {
                if (opened) {
                    throw new IllegalStateException(
                            "The stream was already opened.");
                }
                if (((Closeable) stream).isClosed()) {
                    throw new FileItemStream.ItemSkippedException();
                }
                return stream;
            }