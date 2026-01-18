     func isUseMultiBlock(isAcceptRange:Bool){
        // output stream not support seek
        if (!Download4cj.withs().outputStreamFactory().supportSeek()){
            return false
        }
         //  support range
        return isAcceptRange
    }