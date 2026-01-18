  static FormatInformation decodeFormatInformation(int maskedFormatInfo1, int maskedFormatInfo2) {
    FormatInformation formatInfo = doDecodeFormatInformation(maskedFormatInfo1, maskedFormatInfo2);
    if (formatInfo != null) {
      return formatInfo;
    }
    // Should return null, but, some QR codes apparently
    // do not mask this info. Try again by actually masking the pattern
    // first
    return doDecodeFormatInformation(maskedFormatInfo1 ^ FORMAT_INFO_MASK_QR,
                                     maskedFormatInfo2 ^ FORMAT_INFO_MASK_QR);
  }
