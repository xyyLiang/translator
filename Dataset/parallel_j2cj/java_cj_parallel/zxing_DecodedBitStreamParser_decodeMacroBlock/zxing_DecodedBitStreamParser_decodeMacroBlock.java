  @SuppressWarnings("deprecation")
  static int decodeMacroBlock(int[] codewords, int codeIndex, PDF417ResultMetadata resultMetadata)
      throws FormatException {
    if (codeIndex + NUMBER_OF_SEQUENCE_CODEWORDS > codewords[0]) {
      // we must have at least two bytes left for the segment index
      throw FormatException.getFormatInstance();
    }
    int[] segmentIndexArray = new int[NUMBER_OF_SEQUENCE_CODEWORDS];
    for (int i = 0; i < NUMBER_OF_SEQUENCE_CODEWORDS; i++, codeIndex++) {
      segmentIndexArray[i] = codewords[codeIndex];
    }
    String segmentIndexString = decodeBase900toBase10(segmentIndexArray, NUMBER_OF_SEQUENCE_CODEWORDS);
    if (segmentIndexString.isEmpty()) {
      resultMetadata.setSegmentIndex(0);
    } else {
      try {
        resultMetadata.setSegmentIndex(Integer.parseInt(segmentIndexString));
      } catch (NumberFormatException nfe) {
        // too large; bad input?
        throw FormatException.getFormatInstance();
      }
    }

    // Decoding the fileId codewords as 0-899 numbers, each 0-filled to width 3. This follows the spec
    // (See ISO/IEC 15438:2015 Annex H.6) and preserves all info, but some generators (e.g. TEC-IT) write
    // the fileId using text compaction, so in those cases the fileId will appear mangled.
    StringBuilder fileId = new StringBuilder();
    while (codeIndex < codewords[0] &&
           codeIndex < codewords.length &&
           codewords[codeIndex] != MACRO_PDF417_TERMINATOR &&
           codewords[codeIndex] != BEGIN_MACRO_PDF417_OPTIONAL_FIELD) {
      fileId.append(String.format("%03d", codewords[codeIndex]));
      codeIndex++;
    }
    if (fileId.length() == 0) {
      // at least one fileId codeword is required (Annex H.2)
      throw FormatException.getFormatInstance();
    }
    resultMetadata.setFileId(fileId.toString());

    int optionalFieldsStart = -1;
    if (codewords[codeIndex] == BEGIN_MACRO_PDF417_OPTIONAL_FIELD) {
      optionalFieldsStart = codeIndex + 1;
    }

    while (codeIndex < codewords[0]) {
      switch (codewords[codeIndex]) {
        case BEGIN_MACRO_PDF417_OPTIONAL_FIELD:
          codeIndex++;
          switch (codewords[codeIndex]) {
            case MACRO_PDF417_OPTIONAL_FIELD_FILE_NAME:
              ECIStringBuilder fileName = new ECIStringBuilder();
              codeIndex = textCompaction(codewords, codeIndex + 1, fileName);
              resultMetadata.setFileName(fileName.toString());
              break;
            case MACRO_PDF417_OPTIONAL_FIELD_SENDER:
              ECIStringBuilder sender = new ECIStringBuilder();
              codeIndex = textCompaction(codewords, codeIndex + 1, sender);
              resultMetadata.setSender(sender.toString());
              break;
            case MACRO_PDF417_OPTIONAL_FIELD_ADDRESSEE:
              ECIStringBuilder addressee = new ECIStringBuilder();
              codeIndex = textCompaction(codewords, codeIndex + 1, addressee);
              resultMetadata.setAddressee(addressee.toString());
              break;
            case MACRO_PDF417_OPTIONAL_FIELD_SEGMENT_COUNT:
              ECIStringBuilder segmentCount = new ECIStringBuilder();
              codeIndex = numericCompaction(codewords, codeIndex + 1, segmentCount);
              try {
                resultMetadata.setSegmentCount(Integer.parseInt(segmentCount.toString()));
              } catch (NumberFormatException nfe) {
                throw FormatException.getFormatInstance();
              }
              break;
            case MACRO_PDF417_OPTIONAL_FIELD_TIME_STAMP:
              ECIStringBuilder timestamp = new ECIStringBuilder();
              codeIndex = numericCompaction(codewords, codeIndex + 1, timestamp);
              try {
                resultMetadata.setTimestamp(Long.parseLong(timestamp.toString()));
              } catch (NumberFormatException nfe) {
                throw FormatException.getFormatInstance();
              }
              break;
            case MACRO_PDF417_OPTIONAL_FIELD_CHECKSUM:
              ECIStringBuilder checksum = new ECIStringBuilder();
              codeIndex = numericCompaction(codewords, codeIndex + 1, checksum);
              try {
                resultMetadata.setChecksum(Integer.parseInt(checksum.toString()));
              } catch (NumberFormatException nfe) {
                throw FormatException.getFormatInstance();
              }
              break;
            case MACRO_PDF417_OPTIONAL_FIELD_FILE_SIZE:
              ECIStringBuilder fileSize = new ECIStringBuilder();
              codeIndex = numericCompaction(codewords, codeIndex + 1, fileSize);
              try {
                resultMetadata.setFileSize(Long.parseLong(fileSize.toString()));
              } catch (NumberFormatException nfe) {
                throw FormatException.getFormatInstance();
              }
              break;
            default:
              throw FormatException.getFormatInstance();
          }
          break;
        case MACRO_PDF417_TERMINATOR:
          codeIndex++;
          resultMetadata.setLastSegment(true);
          break;
        default:
          throw FormatException.getFormatInstance();
      }
    }

    // copy optional fields to additional options
    if (optionalFieldsStart != -1) {
      int optionalFieldsLength = codeIndex - optionalFieldsStart;
      if (resultMetadata.isLastSegment()) {
        // do not include terminator
        optionalFieldsLength--;
      }
      if (optionalFieldsLength > 0) {
        resultMetadata.setOptionalData(Arrays.copyOfRange(codewords,
            optionalFieldsStart, optionalFieldsStart + optionalFieldsLength));
      }
    }

    return codeIndex;
  }
