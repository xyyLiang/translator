  private void encodeLowLevel(CharSequence fullCodewords,
                              int c,
                              int r,
                              int errorCorrectionLevel,
                              BarcodeMatrix logic) {

    int idx = 0;
    for (int y = 0; y < r; y++) {
      int cluster = y % 3;
      logic.startRow();
      encodeChar(START_PATTERN, 17, logic.getCurrentRow());

      int left;
      int right;
      if (cluster == 0) {
        left = (30 * (y / 3)) + ((r - 1) / 3);
        right = (30 * (y / 3)) + (c - 1);
      } else if (cluster == 1) {
        left = (30 * (y / 3)) + (errorCorrectionLevel * 3) + ((r - 1) % 3);
        right = (30 * (y / 3)) + ((r - 1) / 3);
      } else {
        left = (30 * (y / 3)) + (c - 1);
        right = (30 * (y / 3)) + (errorCorrectionLevel * 3) + ((r - 1) % 3);
      }

      int pattern = CODEWORD_TABLE[cluster][left];
      encodeChar(pattern, 17, logic.getCurrentRow());

      for (int x = 0; x < c; x++) {
        pattern = CODEWORD_TABLE[cluster][fullCodewords.charAt(idx)];
        encodeChar(pattern, 17, logic.getCurrentRow());
        idx++;
      }

      if (compact) {
        encodeChar(STOP_PATTERN, 1, logic.getCurrentRow()); // encodes stop line for compact pdf417
      } else {
        pattern = CODEWORD_TABLE[cluster][right];
        encodeChar(pattern, 17, logic.getCurrentRow());

        encodeChar(STOP_PATTERN, 18, logic.getCurrentRow());
      }
    }
  }
