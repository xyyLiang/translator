    func startBlocks(tasks:ArrayList<DownloadChain>):Unit{

        var futures:ArrayList<Future<Unit>> = ArrayList<Future<Unit>>(tasks.size)

        try{
            for(i in 0..tasks.size){
                let fut : Future<Unit> = spawn{ =>
                    let task:DownloadChain = tasks.get(i).getOrThrow()
                    if(task.isFinished()){
                        throw  IllegalAccessException("The chain has been finished!")
                    }
                    try{
                        task.start()
                    }catch(e:Exception){
                    }finally{
                        try{
                            task.finished.store(true)
                            task.releaseConnectionAsync()
                        }catch(e:Exception){

                        }
                    }
                }
                futures.append(fut)
            }
            blockChainList.appendAll(tasks)
            for(future in futures){
                future.get()
            }

        }catch(e:Exception){
            throw e
        }finally{
            doDelete(blockChainList,tasks)
        }
    }