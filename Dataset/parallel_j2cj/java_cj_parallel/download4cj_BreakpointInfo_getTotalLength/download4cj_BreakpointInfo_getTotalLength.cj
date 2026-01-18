    func getTotalLength():Int64{
         if (isChunked()){
            return getTotalOffset()
         }

         var length:Int64 = 0
         for(block in blockInfoList){
            length += block.getContentLength()
         }
         return length
    }