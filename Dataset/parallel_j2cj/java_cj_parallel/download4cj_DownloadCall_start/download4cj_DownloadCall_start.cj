    func start(cache:DownloadCache,info:BreakpointInfo):Unit{
        let blockCount:Int64 = info.getBlockCount()
        let blockChainList:ArrayList<DownloadChain> = ArrayList<DownloadChain>(info.getBlockCount())
        let blockIndexList:ArrayList<Int64> = ArrayList<Int64>()
        for(i in 0..blockCount){
            let blockInfo:BlockInfo = info.getBlock(i).getOrThrow()
            if (Util.isCorrectFull(blockInfo.getCurrentOffset(), blockInfo.getContentLength())) {
                continue
            }
            Util.resetBlockIfDirty(blockInfo)
            let chain:DownloadChain = DownloadChain.createChain(i, task, info, cache, store)
            blockChainList.append(chain)
            blockIndexList.append(chain.getBlockIndex())
        }

        if (canceled) {
            return
        }

        cache.getOutputStream().setRequireStreamBlocks(blockIndexList)
        startBlocks(blockChainList)

    }