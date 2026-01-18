  private static BitArray generateCheckWords(BitArray bitArray, int totalBits, int wordSize) {
    // bitArray is guaranteed to be a multiple of the wordSize, so no padding needed
    int messageSizeInWords = bitArray.getSize() / wordSize;
    ReedSolomonEncoder rs = new ReedSolomonEncoder(getGF(wordSize));
    int totalWords = totalBits / wordSize;
    int[] messageWords = bitsToWords(bitArray, wordSize, totalWords);
    rs.encode(messageWords, totalWords - messageSizeInWords);
    int startPad = totalBits % wordSize;
    BitArray messageBits = new BitArray();
    messageBits.appendBits(0, startPad);
    for (int messageWord : messageWords) {
      messageBits.appendBits(messageWord, wordSize);
    }
    return messageBits;
  }