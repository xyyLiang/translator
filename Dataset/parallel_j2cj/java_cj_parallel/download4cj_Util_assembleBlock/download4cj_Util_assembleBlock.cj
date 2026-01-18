     static func assembleBlock(task:DownloadTask,info:BreakpointInfo,instanceLength:Int64,isAcceptRange:Bool):Unit{
        let blockCount:Int64
        if (Download4cj.withs().downloadStrategy().isUseMultiBlock(isAcceptRange)) {
            blockCount = Download4cj.withs().downloadStrategy().determineBlockCount(task, instanceLength)
        } else {
            blockCount = 1
        }
        info.resetBlockInfos()
        let eachLength:Int64 =  instanceLength / blockCount
        var startOffset:Int64 = 0
        var contentLength:Int64 = 0
        for(i in 0..blockCount){
            startOffset = startOffset + contentLength
            if(i == 0){
                let remainLength:Int64 = instanceLength % blockCount
                contentLength = eachLength + remainLength
            }else{
                 contentLength = eachLength
            }
            let blockInfo:BlockInfo = BlockInfo(startOffset, contentLength)
            info.addBlock(blockInfo)
        }
    }