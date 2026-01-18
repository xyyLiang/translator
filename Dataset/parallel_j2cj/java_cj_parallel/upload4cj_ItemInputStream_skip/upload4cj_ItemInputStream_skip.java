        @Override
        public long skip(long bytes) throws IOException {
            if (closed) {
                throw new FileItemStream.ItemSkippedException();
            }
            int av = available();
            if (av == 0) {
                av = makeAvailable();
                if (av == 0) {
                    return 0;
                }
            }
            long res = Math.min(av, bytes);
            head += res;
            return res;
        }