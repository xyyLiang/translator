  static Result constructResult(List<ExpandedPair> pairs) throws NotFoundException, FormatException {
    BitArray binary = BitArrayBuilder.buildBitArray(pairs);

    AbstractExpandedDecoder decoder = AbstractExpandedDecoder.createDecoder(binary);
    String resultingString = decoder.parseInformation();

    ResultPoint[] firstPoints = pairs.get(0).getFinderPattern().getResultPoints();
    ResultPoint[] lastPoints  = pairs.get(pairs.size() - 1).getFinderPattern().getResultPoints();

    Result result = new Result(
          resultingString,
          null,
          new ResultPoint[]{firstPoints[0], firstPoints[1], lastPoints[0], lastPoints[1]},
          BarcodeFormat.RSS_EXPANDED
      );
    result.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]e0");
    return result;
  }
