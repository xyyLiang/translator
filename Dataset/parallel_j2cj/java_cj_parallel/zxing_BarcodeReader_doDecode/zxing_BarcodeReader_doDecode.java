  private Result doDecode(BinaryBitmap image,
                          Map<DecodeHintType,?> hints) throws NotFoundException {
    int width = image.getWidth();
    int height = image.getHeight();
    BitArray row = new BitArray(width);

    boolean tryHarder = hints != null && hints.containsKey(DecodeHintType.TRY_HARDER);
    int rowStep = Math.max(1, height >> (tryHarder ? 8 : 5));
    int maxLines;
    if (tryHarder) {
      maxLines = height; // Look at the whole image, not just the center
    } else {
      maxLines = 15; // 15 rows spaced 1/32 apart is roughly the middle half of the image
    }

    int middle = height / 2;
    for (int x = 0; x < maxLines; x++) {

      // Scanning from the middle out. Determine which row we're looking at next:
      int rowStepsAboveOrBelow = (x + 1) / 2;
      boolean isAbove = (x & 0x01) == 0; // i.e. is x even?
      int rowNumber = middle + rowStep * (isAbove ? rowStepsAboveOrBelow : -rowStepsAboveOrBelow);
      if (rowNumber < 0 || rowNumber >= height) {
        // Oops, if we run off the top or bottom, stop
        break;
      }

      // Estimate black point for this row and load it:
      try {
        row = image.getBlackRow(rowNumber, row);
      } catch (NotFoundException ignored) {
        continue;
      }

      // While we have the image data in a BitArray, it's fairly cheap to reverse it in place to
      // handle decoding upside down barcodes.
      for (int attempt = 0; attempt < 2; attempt++) {
        if (attempt == 1) { // trying again?
          row.reverse(); // reverse the row and continue
          // This means we will only ever draw result points *once* in the life of this method
          // since we want to avoid drawing the wrong points after flipping the row, and,
          // don't want to clutter with noise from every single row scan -- just the scans
          // that start on the center line.
          if (hints != null && hints.containsKey(DecodeHintType.NEED_RESULT_POINT_CALLBACK)) {
            Map<DecodeHintType,Object> newHints = new EnumMap<>(DecodeHintType.class);
            newHints.putAll(hints);
            newHints.remove(DecodeHintType.NEED_RESULT_POINT_CALLBACK);
            hints = newHints;
          }
        }
        try {
          // Look for a barcode
          Result result = decodeRow(rowNumber, row, hints);
          // We found our barcode
          if (attempt == 1) {
            // But it was upside down, so note that
            result.putMetadata(ResultMetadataType.ORIENTATION, 180);
            // And remember to flip the result points horizontally.
            ResultPoint[] points = result.getResultPoints();
            if (points != null) {
              points[0] = new ResultPoint(width - points[0].getX() - 1, points[0].getY());
              points[1] = new ResultPoint(width - points[1].getX() - 1, points[1].getY());
            }
          }
          return result;
        } catch (ReaderException re) {
          // continue -- just couldn't decode this row
        }
      }
    }

    throw NotFoundException.getNotFoundInstance();
  }
