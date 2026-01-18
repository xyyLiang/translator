    func getTotalOffset():Int64{
        var offset:Int64 = 0
        for(block in blockInfoList){
            offset += block.getCurrentOffset()
        }
        return offset
    }