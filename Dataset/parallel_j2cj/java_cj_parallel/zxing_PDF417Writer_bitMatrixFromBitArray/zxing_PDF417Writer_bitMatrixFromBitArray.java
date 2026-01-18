  private static BitMatrix bitMatrixFromBitArray(byte[][] input, int margin) {
    // Creates the bit matrix with extra space for whitespace
    BitMatrix output = new BitMatrix(input[0].length + 2 * margin, input.length + 2 * margin);
    output.clear();
    for (int y = 0, yOutput = output.getHeight() - margin - 1; y < input.length; y++, yOutput--) {
      byte[] inputY = input[y];
      for (int x = 0; x < input[0].length; x++) {
        // Zero is white in the byte matrix
        if (inputY[x] == 1) {
          output.set(x + margin, yOutput);
        }
      }
    }
    return output;
  }
