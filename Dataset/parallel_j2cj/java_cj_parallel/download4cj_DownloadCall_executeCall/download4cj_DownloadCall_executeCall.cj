    func executeCall():Unit{
        var retry:Bool = false
        var retryCount:Int64 = 0
        // ready param
        let download4cj:Download4cj = Download4cj.withs()
        let fileStrategy:ProcessFileStrategy = download4cj.processFileStrategy()
        //inspect task start
        inspectTaskStart()
        do{
            // 0. check basic param before start
            if(task.getUrl().size <= 0){
                this.cache = PreError(IOException("unexpected url: "+task.getUrl()))
                break
            }
             if (canceled){
                break
             }

             // 1. create basic info if not exist
             var info:BreakpointInfo
              try{
                var infoOnStore:Option<BreakpointInfo> = store.get(task.getId())
                if(let Some(i) <- infoOnStore){
                    info = i
                }else{
                    info = store.createAndInsert(task)
                }
                setInfoToTask(info)
             }catch(e:IOException){
                 info = BreakpointInfo(0,"",Option<Directory>.None,"")
                 this.cache = PreError(e)
                break
             }
             if (canceled){
                break
             }
            // 2. remote check.
            let remoteCheck:BreakpointRemoteCheck = createRemoteCheck(info)
            try {
                remoteCheck.check()
            } catch (e:ReadWriteException) {
                break
            }
            // ready cache.
            let cachea:DownloadCache = createCache(info)
            this.cache = cachea
            if(!Util.isEmpty(task.getRedirectLocation())){
                cache.getOrThrow().setRedirectLocation(task.getRedirectLocation())
            }
            // 3. waiting for file lock release after file path is confirmed.
              // 4. reuse another info if another info is idle and available for reuse.
            Download4cj.withs().downloadStrategy().inspectAnotherSameInfo(task, info, remoteCheck.getInstanceLength())
            try{
                 if (remoteCheck.isResumable()) {
                         // 5. local check
                    let localCheck:BreakpointLocalCheck = createLocalCheck(info,remoteCheck.getInstanceLength())
                    localCheck.check()
                    if(localCheck.isDirty()) {
                        Util.d(TAG, "breakpoint invalid: download from beginning because of local check is dirty "+task.getId().toString()+" "+localCheck.toString())
                         // 6. assemble block data
                        fileStrategy.discardProcess(task)
                        assembleBlockAndCallbackFromBeginning(info,remoteCheck)
                    }else{
                         download4cj.callbackDispatcher().dispatch().downloadFromBreakpoint(task)
                    }
                 }
            }catch(e:IOException){
                cache.getOrThrow().setUnknownError(e)
                break
            }

            // 7. start with cache and info.
            start(cache.getOrThrow(), info)

            if (canceled){
                break
            }

             // 8. retry if precondition failed.
            retryCount++
            if (cache.getOrThrow().isPreconditionFailed() && retryCount < MAX_COUNT_RETRY_FOR_PRECONDITION_FAILEDA) {
                //移除对应的id
                store.remove(task.getId())
                //重新开始
                retry = true
            } else {
                //不用重新开始
                retry = false
            }
        }while(retry)

        // finish
        finishing = true
        blockChainList.clear()

        let cache:Option<DownloadCache> = this.cache
        if (canceled){
            return
        }

        if(let Some(_) <- cache){
        }else{
            return
        }

        var cause:EndCause = EndCause.COMPLETED
        var realCause:Option<Exception> = Option<Exception>.None
        if (cache.getOrThrow().isServerCanceled() || cache.getOrThrow().isUnknownError() || cache.getOrThrow().isPreconditionFailed()) {
            cause = EndCause.ERROR
            realCause = cache.getOrThrow().getRealCause()
        } else if (cache.getOrThrow().isFileBusyAfterRun()) {
            cause = EndCause.FILE_BUSY
        } else if (cache.getOrThrow().isPreAllocateFailed()) {
            cause = EndCause.PRE_ALLOCATE_FAILED
            realCause = cache.getOrThrow().getRealCause()
        } else {
            cause = EndCause.COMPLETED
        }
         inspectTaskEnd(cause, realCause)
    }