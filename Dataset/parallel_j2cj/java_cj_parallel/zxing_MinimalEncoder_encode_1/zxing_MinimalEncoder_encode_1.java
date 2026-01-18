    private int encode(CharSequence contents, Charset charset, int position) {
      assert position < contents.length();
      int mCost = memoizedCost[charset.ordinal()][position];
      if (mCost > 0) {
        return mCost;
      }

      int minCost = Integer.MAX_VALUE;
      Latch minLatch = Latch.NONE;
      boolean atEnd = position + 1 >= contents.length();

      Charset[] sets = new Charset[] { Charset.A, Charset.B };
      for (int i = 0; i <= 1; i++) {
        if (canEncode(contents, sets[i], position)) {
          int cost =  1;
          Latch latch = Latch.NONE;
          if (charset != sets[i]) {
            cost++;
            latch = Latch.valueOf(sets[i].toString());
          }
          if (!atEnd) {
            cost += encode(contents, sets[i], position + 1);
          }
          if (cost < minCost) {
            minCost = cost;
            minLatch = latch;
          }
          cost = 1;
          if (charset == sets[(i + 1) % 2]) {
            cost++;
            latch = Latch.SHIFT;
            if (!atEnd) {
              cost += encode(contents, charset, position + 1);
            }
            if (cost < minCost) {
              minCost = cost;
              minLatch = latch;
            }
          }
        }
      }
      if (canEncode(contents, Charset.C, position)) {
        int cost = 1;
        Latch latch = Latch.NONE;
        if (charset != Charset.C) {
          cost++;
          latch = Latch.C;
        }
        int advance = contents.charAt(position) == ESCAPE_FNC_1 ? 1 : 2;
        if (position + advance < contents.length()) {
          cost += encode(contents, Charset.C, position + advance);
        }
        if (cost < minCost) {
          minCost = cost;
          minLatch = latch;
        }
      }
      if (minCost == Integer.MAX_VALUE) {
        throw new IllegalArgumentException("Bad character in input: ASCII value=" + (int) contents.charAt(position));
      }
      memoizedCost[charset.ordinal()][position] = minCost;
      minPath[charset.ordinal()][position] = minLatch;
      return minCost;
    }
  }
