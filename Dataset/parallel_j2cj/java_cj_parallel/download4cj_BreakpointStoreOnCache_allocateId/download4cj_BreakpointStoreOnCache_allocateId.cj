    func allocateId():Int64{
        synchronized(m){

            var newId:Int64 = 0
            var index:Int64 = 0
            var preId:Int64 = 0
            var curId:Int64
            for(i in 0..sortedOccupiedIds.size){
                 let curIdObj:Option<Int64> = sortedOccupiedIds.get(i)
                if(let Some(_) <- curIdObj){

                }else{
                    index = i
                    newId = preId + 1
                    break
                }
                 curId = curIdObj.getOrThrow()
                 if (preId == 0) {
                    if (curId != FIRST_ID) {
                        newId = FIRST_ID
                        index = 0
                        break
                    }
                    preId = curId
                    continue
                 }
                if (curId != preId + 1) {
                    newId = preId + 1
                    index = i
                    break
                }
                  preId = curId
            }

            if (newId == 0) {
                if (sortedOccupiedIds.isEmpty()) {
                    newId = FIRST_ID
                } else {
                    newId = sortedOccupiedIds.get(sortedOccupiedIds.size - 1).getOrThrow() + 1
                    index = sortedOccupiedIds.size
                }
            }

            sortedOccupiedIds.insert(index, newId)
            return newId
        }
    }