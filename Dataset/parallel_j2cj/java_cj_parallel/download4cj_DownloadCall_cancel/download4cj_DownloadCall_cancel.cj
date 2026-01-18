    func cancel():Bool{
        synchronized(m){
            if (canceled){
                return false
            }

            if(finishing){
                return false
            }

            this.canceled = true
        }
        let startCancelTime:Int64 = DateTime.now().toUnixTimeStamp().toNanoseconds() / 1000 /1000
        Download4cj.withs().downloadDispatcher().flyingCanceled(this)
        let cache:Option<DownloadCache> = this.cache
        if(let Some(i) <- cache){
            i.setUserCanceled()
        }
        let chains:Array<DownloadChain> = blockChainList.toArray()
        if(chains.size == 0){
              Util.d(TAG,"interrupt thread with cancel operation because of chains are not running "+ task.getId().toString())
        }else{
            for (chain in chains) {
                chain.cancel()
            }
        }

        if(let Some(i) <- cache){
            i.getOutputStream().cancelAsync()
        }
        Util.d(TAG, "cancel task " + task.getId().toString() + " consume: " + (DateTime.now().toUnixTimeStamp().toNanoseconds() / 1000 /1000 - startCancelTime).toString() + "ms")
        return true
    }