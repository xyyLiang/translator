    void updateEntryFromPaxHeaders(final Map<String, String> headers) throws IOException {
        for (final Map.Entry<String, String> ent : headers.entrySet()) {
            processPaxHeader(ent.getKey(), ent.getValue(), headers);
        }
    }