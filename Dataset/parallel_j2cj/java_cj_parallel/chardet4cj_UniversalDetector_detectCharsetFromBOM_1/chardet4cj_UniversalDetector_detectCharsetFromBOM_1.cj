    private static func detectCharsetFromBOM(buf: Array<Byte>, offset: Int32): String {
        if (buf.size > Int64(offset + 3)) {
   let b1 = buf[Int64(offset)] & 0xFF
   let b2 = buf[Int64(offset+1)] & 0xFF
   let b3 = buf[Int64(offset+2)] & 0xFF
   let b4 = buf[Int64(offset+3)] & 0xFF
            match (b1) {
                case 0xEF =>
                    if (b2 == 0xBB && b3 == 0xBF) {
               return Constants.CHARSET_UTF_8
           }
                
                case 0xFE =>
                    if (b2 == 0xFF && b3 == 0x00 && b4 == 0x00) {
                        return "CHARSET_X_ISO_10646_UCS_4_3412"
           } else if (b2 == 0xFF) {
               return Constants.CHARSET_UTF_16BE
           }
                case 0x00 =>
                    if (b2 == 0x00 && b3 == 0xFE && b4 == 0xFF) {
                        return "CHARSET_UTF_32BE"
           } else if (b2 == 0x00 && b3 == 0xFF && b4 == 0xFE) {
                        return "CHARSET_X_ISO_10646_UCS_4_2143"
           } 
                case 0xFF => 
                    if (b2 == 0xFE && b3 == 0x00 && b4 == 0x00) {
                        return "CHARSET_UTF_32LE"
           } else if (b2 == 0xFE) {
               return Constants.CHARSET_UTF_16LE
           }   
                case _ =>
                    ()
            }
     
        }
        return ""  
    }