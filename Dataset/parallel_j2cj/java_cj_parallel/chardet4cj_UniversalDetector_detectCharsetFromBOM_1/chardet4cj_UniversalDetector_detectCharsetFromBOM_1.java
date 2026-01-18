 private static String detectCharsetFromBOM(final byte[] buf, int offset) {
  if (buf.length > (offset + 3)) {
   int b1 = buf[offset] & 0xFF;
   int b2 = buf[offset+1] & 0xFF;
   int b3 = buf[offset+2] & 0xFF;
   int b4 = buf[offset+3] & 0xFF;
   
   switch (b1) {
   case 0xEF:
       if (b2 == 0xBB && b3 == 0xBF) {
           return CHARSET_UTF_8;
       }
       break;
   case 0xFE:
       if (b2 == 0xFF && b3 == 0x00 && b4 == 0x00) {
           return CHARSET_X_ISO_10646_UCS_4_3412;
       } else if (b2 == 0xFF) {
           return CHARSET_UTF_16BE;
       }
       break;
   case 0x00:
       if (b2 == 0x00 && b3 == 0xFE && b4 == 0xFF) {
           return CHARSET_UTF_32BE;
       } else if (b2 == 0x00 && b3 == 0xFF && b4 == 0xFE) {
           return CHARSET_X_ISO_10646_UCS_4_2143;
       }
       break;
   case 0xFF:
       if (b2 == 0xFE && b3 == 0x00 && b4 == 0x00) {
           return CHARSET_UTF_32LE;
       } else if (b2 == 0xFE) {
           return CHARSET_UTF_16LE;
       }
       break;
   default: 
    break;
   } // swich end
  }
  return null;
 }
