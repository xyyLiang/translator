  @Override
  public boolean[] encode(String contents) {
    contents = convertToExtended(contents);
    int length = contents.length();
    if (length > 80) {
      throw new IllegalArgumentException("Requested contents should be less than 80 digits long after " +
          "converting to extended encoding, but got " + length);
    }

    //length of code + 2 start/stop characters + 2 checksums, each of 9 bits, plus a termination bar
    int codeWidth = (contents.length() + 2 + 2) * 9 + 1;

    boolean[] result = new boolean[codeWidth];

    //start character (*)
    int pos = appendPattern(result, 0, Code93Reader.ASTERISK_ENCODING);

    for (int i = 0; i < length; i++) {
      int indexInString = Code93Reader.ALPHABET_STRING.indexOf(contents.charAt(i));
      pos += appendPattern(result, pos, Code93Reader.CHARACTER_ENCODINGS[indexInString]);
    }

    //add two checksums
    int check1 = computeChecksumIndex(contents, 20);
    pos += appendPattern(result, pos, Code93Reader.CHARACTER_ENCODINGS[check1]);

    //append the contents to reflect the first checksum added
    contents += Code93Reader.ALPHABET_STRING.charAt(check1);

    int check2 = computeChecksumIndex(contents, 15);
    pos += appendPattern(result, pos, Code93Reader.CHARACTER_ENCODINGS[check2]);

    //end character (*)
    pos += appendPattern(result, pos, Code93Reader.ASTERISK_ENCODING);

    //termination bar (single black bar)
    result[pos] = true;

    return result;
  }
