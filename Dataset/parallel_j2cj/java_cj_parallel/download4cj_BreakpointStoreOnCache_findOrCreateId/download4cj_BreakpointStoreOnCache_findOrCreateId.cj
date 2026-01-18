    public func findOrCreateId(task:DownloadTask):Int64{
        synchronized(m){
            let candidate:Option<Int64> = keyToIdMap.get(task)
            if(let Some(i) <- candidate){
                return i
            }
            let itera:Iterator<Int64>  = storedInfos.keys().iterator()
            while(true){
               var optKey:Option<Int64> = itera.next()
               match(optKey){
                    case Some(v)=>
                       let info:Option<BreakpointInfo> =  storedInfos.get(v).getOrThrow()
                       if(let Some(j) <- info){
                          if(j.isSameFrom(task)){
                             return j.id
                          }
                       }
                    case None => break
               }
            }
           let itera2:Iterator<Int64>  = unStoredTasks.keys().iterator()
           while(true){
                var optKey:Option<Int64> = itera2.next()
                match(optKey){
                    case Some(v)=>
                       let another:Option<IdentifiedTask> =  unStoredTasks.get(v).getOrThrow()
                        if(let Some(k) <- another){
                            if(k.compareIgnoreId(task)){
                                return k.getId()
                            }
                        }else{
                         continue
                        }
                    case None => break
                }
           }
           let id:Int64 = allocateId()
           unStoredTasks.put(id, task.mock(id))
           keyToIdMap.add(task, id)
           return id
        }
    }