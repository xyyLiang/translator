    private func addRecordValue(lastRecord: Bool): Unit {
        let input = this.reusableToken.content.toString();

        if (lastRecord && input.isEmpty() && this.format.getTrailingDelimiter()) {
            return
        }

        if (lastRecord && input.isEmpty() && this.columnValueList.size == 0) {
            return
        }

        this.columnValueList.append(input);
    }
