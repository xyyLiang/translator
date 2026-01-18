    public init(inputStream: InputStream, skipIfFound: Bool) {
        
        if ((inputStream as Seekable).getOrThrow().length == 0) {
   throw ChardetException("invalid input stream: null is not allowed")
  }
        ins = inputStream
        var boms: Array<Byte> = Array<Byte>(4, item: 0)

        var read = ins.read(boms)

        match (read) {
      case 4 =>
       if (checkval(boms)) {
        this.bom = BOM.UTF_32_LE
                    
       } else if (checkval2(boms)) {
        this.bom = BOM.UTF_32_BE
                    
       }
            case 3 =>
       if (checkval3(boms)){
        this.bom = BOM.UTF_8 
                    
       }
            case 2 =>
       if ((boms[0] == 0xFF) && (boms[1] == 0xFE)) {
        this.bom = BOM.UTF_16_LE
                    
       } else if ((boms[0] == 0xFE) && (boms[1] == 0xFF)) {
        this.bom = BOM.UTF_16_BE
                    
       }
            case _ =>
                this.bom = BOM.NONE    
        }

        if (bom.toString().isEmpty()) {
      this.bom = BOM.NONE
  }

        if (skipIfFound) {
   if (!skipped) {
       var bytesToSkip: Int64 = bom.bytes.size
                var bytesSkipped: Int64 = -1
                if (bytesToSkip < (ins as Seekable).getOrThrow().length) {
                    bytesSkipped = bytesToSkip
                } else {
                    bytesSkipped = (ins as Seekable).getOrThrow().length
                }
                if (bytesSkipped > 0) {
                    var skips: Array<Byte> = Array<Byte>(bytesSkipped, item: 0)
                    ins.read(skips)
                }
                var byteskips: Array<Byte> = Array<Byte>(1, item: 0)
       for (_ in bytesSkipped..bytesToSkip) {
        ins.read(byteskips)
       }
       skipped = true
      }
  
     }
  
    }  