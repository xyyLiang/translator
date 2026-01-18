    private void addRecordValue(final boolean lastRecord) {
        final String input = this.format.trim(this.reusableToken.content.toString());
        if (lastRecord && input.isEmpty() && this.format.getTrailingDelimiter()) {
            return;
        }
        this.recordList.add(handleNull(input));
    }