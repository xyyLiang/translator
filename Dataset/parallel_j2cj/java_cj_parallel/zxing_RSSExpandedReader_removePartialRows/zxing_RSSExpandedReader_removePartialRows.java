  private static void removePartialRows(Collection<ExpandedPair> pairs, Collection<ExpandedRow> rows) {
    for (Iterator<ExpandedRow> iterator = rows.iterator(); iterator.hasNext();) {
      ExpandedRow r = iterator.next();
      if (r.getPairs().size() != pairs.size()) {
        boolean allFound = true;
        for (ExpandedPair p : r.getPairs()) {
          if (!pairs.contains(p)) {
            allFound = false;
            break;
          }
        }
        if (allFound) {
          // 'pairs' contains all the pairs from the row 'r'
          iterator.remove();
        }
      }
    }
  }
