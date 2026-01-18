  static DecoderResult decode(int[] codewords, String ecLevel) throws FormatException {
    ECIStringBuilder result = new ECIStringBuilder(codewords.length * 2);
    int codeIndex = textCompaction(codewords, 1, result);
    PDF417ResultMetadata resultMetadata = new PDF417ResultMetadata();
    while (codeIndex < codewords[0]) {
      int code = codewords[codeIndex++];
      switch (code) {
        case TEXT_COMPACTION_MODE_LATCH:
          codeIndex = textCompaction(codewords, codeIndex, result);
          break;
        case BYTE_COMPACTION_MODE_LATCH:
        case BYTE_COMPACTION_MODE_LATCH_6:
          codeIndex = byteCompaction(code, codewords, codeIndex, result);
          break;
        case MODE_SHIFT_TO_BYTE_COMPACTION_MODE:
          result.append((char) codewords[codeIndex++]);
          break;
        case NUMERIC_COMPACTION_MODE_LATCH:
          codeIndex = numericCompaction(codewords, codeIndex, result);
          break;
        case ECI_CHARSET:
          result.appendECI(codewords[codeIndex++]);
          break;
        case ECI_GENERAL_PURPOSE:
          // Can't do anything with generic ECI; skip its 2 characters
          codeIndex += 2;
          break;
        case ECI_USER_DEFINED:
          // Can't do anything with user ECI; skip its 1 character
          codeIndex++;
          break;
        case BEGIN_MACRO_PDF417_CONTROL_BLOCK:
          codeIndex = decodeMacroBlock(codewords, codeIndex, resultMetadata);
          break;
        case BEGIN_MACRO_PDF417_OPTIONAL_FIELD:
        case MACRO_PDF417_TERMINATOR:
          // Should not see these outside a macro block
          throw FormatException.getFormatInstance();
        default:
          // Default to text compaction. During testing numerous barcodes
          // appeared to be missing the starting mode. In these cases defaulting
          // to text compaction seems to work.
          codeIndex--;
          codeIndex = textCompaction(codewords, codeIndex, result);
          break;
      }
    }
    if (result.isEmpty() && resultMetadata.getFileId() == null) {
      throw FormatException.getFormatInstance();
    }
    DecoderResult decoderResult = new DecoderResult(null, result.toString(), null, ecLevel);
    decoderResult.setOther(resultMetadata);
    return decoderResult;
  }
