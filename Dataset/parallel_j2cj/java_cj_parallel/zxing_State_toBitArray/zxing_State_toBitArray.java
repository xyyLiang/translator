  BitArray toBitArray(byte[] text) {
    List<Token> symbols = new ArrayList<>();
    for (Token token = endBinaryShift(text.length).token; token != null; token = token.getPrevious()) {
      symbols.add(token);
    }
    BitArray bitArray = new BitArray();
    // Add each token to the result in forward order
    for (int i = symbols.size() - 1; i >= 0; i--) {
      symbols.get(i).appendTo(bitArray, text);
    }
    return bitArray;
  }
