    protected static Map<String, String> parsePaxHeaders(final InputStream inputStream, final List<TarArchiveStructSparse> sparseHeaders,
            final Map<String, String> globalPaxHeaders, final long headerSize) throws IOException {
        final Map<String, String> headers = new HashMap<>(globalPaxHeaders);
        Long offset = null;
        // Format is "length keyword=value\n";
        int totalRead = 0;
        while (true) { // get length
            int ch;
            int len = 0;
            int read = 0;
            while ((ch = inputStream.read()) != -1) {
                read++;
                totalRead++;
                if (ch == '\n') { // blank line in header
                    break;
                }
                if (ch == ' ') { // End of length string
                    // Get keyword
                    final ByteArrayOutputStream coll = new ByteArrayOutputStream();
                    while ((ch = inputStream.read()) != -1) {
                        read++;
                        totalRead++;
                        if (totalRead < 0 || headerSize >= 0 && totalRead >= headerSize) {
                            break;
                        }
                        if (ch == '=') { // end of keyword
                            final String keyword = coll.toString(CharsetNames.UTF_8);
                            // Get rest of entry
                            final int restLen = len - read;
                            if (restLen <= 1) { // only NL
                                headers.remove(keyword);
                            } else if (headerSize >= 0 && restLen > headerSize - totalRead) {
                                throw new IOException("Paxheader value size " + restLen + " exceeds size of header record");
                            } else {
                                final byte[] rest = IOUtils.readRange(inputStream, restLen);
                                final int got = rest.length;
                                if (got != restLen) {
                                    throw new IOException("Failed to read " + "Paxheader. Expected " + restLen + " bytes, read " + got);
                                }
                                totalRead += restLen;
                                // Drop trailing NL
                                if (rest[restLen - 1] != '\n') {
                                    throw new IOException("Failed to read Paxheader." + "Value should end with a newline");
                                }
                                final String value = new String(rest, 0, restLen - 1, StandardCharsets.UTF_8);
                                headers.put(keyword, value);

                                // for 0.0 PAX Headers
                                if (keyword.equals(TarGnuSparseKeys.OFFSET)) {
                                    if (offset != null) {
                                        // previous GNU.sparse.offset header but no numBytes
                                        sparseHeaders.add(new TarArchiveStructSparse(offset, 0));
                                    }
                                    try {
                                        offset = Long.valueOf(value);
                                    } catch (final NumberFormatException ex) {
                                        throw new IOException("Failed to read Paxheader." + TarGnuSparseKeys.OFFSET + " contains a non-numeric value");
                                    }
                                    if (offset < 0) {
                                        throw new IOException("Failed to read Paxheader." + TarGnuSparseKeys.OFFSET + " contains negative value");
                                    }
                                }

                                // for 0.0 PAX Headers
                                if (keyword.equals(TarGnuSparseKeys.NUMBYTES)) {
                                    if (offset == null) {
                                        throw new IOException(
                                                "Failed to read Paxheader." + TarGnuSparseKeys.OFFSET + " is expected before GNU.sparse.numbytes shows up.");
                                    }
                                    final long numbytes = ParsingUtils.parseLongValue(value);
                                    if (numbytes < 0) {
                                        throw new IOException("Failed to read Paxheader." + TarGnuSparseKeys.NUMBYTES + " contains negative value");
                                    }
                                    sparseHeaders.add(new TarArchiveStructSparse(offset, numbytes));
                                    offset = null;
                                }
                            }
                            break;
                        }
                        coll.write((byte) ch);
                    }
                    break; // Processed single header
                }

                // COMPRESS-530 : throw if we encounter a non-number while reading length
                if (ch < '0' || ch > '9') {
                    throw new IOException("Failed to read Paxheader. Encountered a non-number while reading length");
                }

                len *= 10;
                len += ch - '0';
            }
            if (ch == -1) { // EOF
                break;
            }
        }
        if (offset != null) {
            // offset but no numBytes
            sparseHeaders.add(new TarArchiveStructSparse(offset, 0));
        }
        return headers;
    }
