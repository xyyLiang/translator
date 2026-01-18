        @Override
        public int available() throws IOException {
            if (pos == -1) {
                return tail - head - pad;
            }
            return pos - head;
        }