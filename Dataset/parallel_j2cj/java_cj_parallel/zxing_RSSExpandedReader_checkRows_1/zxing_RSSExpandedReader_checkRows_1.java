  private List<ExpandedPair> checkRows(List<ExpandedRow> collectedRows, int currentRow) throws NotFoundException {
    for (int i = currentRow; i < rows.size(); i++) {
      ExpandedRow row = rows.get(i);
      this.pairs.clear();
      for (ExpandedRow collectedRow : collectedRows) {
        this.pairs.addAll(collectedRow.getPairs());
      }
      this.pairs.addAll(row.getPairs());

      if (isValidSequence(this.pairs, false)) {
        if (checkChecksum()) {
          return this.pairs;
        }

        List<ExpandedRow> rs = new ArrayList<>(collectedRows);
        rs.add(row);
        try {
          // Recursion: try to add more rows
          return checkRows(rs, i + 1);
        } catch (NotFoundException e) {
          // We failed, try the next candidate
        }
      }
    }

    throw NotFoundException.getNotFoundInstance();
  }
