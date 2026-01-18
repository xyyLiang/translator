  private static void decodeMiddle(BitArray row,
                                   int payloadStart,
                                   int payloadEnd,
                                   StringBuilder resultString) throws NotFoundException {

    // Digits are interleaved in pairs - 5 black lines for one digit, and the
    // 5
    // interleaved white lines for the second digit.
    // Therefore, need to scan 10 lines and then
    // split these into two arrays
    int[] counterDigitPair = new int[10];
    int[] counterBlack = new int[5];
    int[] counterWhite = new int[5];

    while (payloadStart < payloadEnd) {

      // Get 10 runs of black/white.
      recordPattern(row, payloadStart, counterDigitPair);
      // Split them into each array
      for (int k = 0; k < 5; k++) {
        int twoK = 2 * k;
        counterBlack[k] = counterDigitPair[twoK];
        counterWhite[k] = counterDigitPair[twoK + 1];
      }

      int bestMatch = decodeDigit(counterBlack);
      resultString.append((char) ('0' + bestMatch));
      bestMatch = decodeDigit(counterWhite);
      resultString.append((char) ('0' + bestMatch));

      for (int counterDigit : counterDigitPair) {
        payloadStart += counterDigit;
      }
    }
  }
