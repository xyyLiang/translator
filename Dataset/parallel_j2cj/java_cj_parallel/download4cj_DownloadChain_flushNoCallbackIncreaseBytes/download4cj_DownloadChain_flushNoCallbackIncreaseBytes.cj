    func flushNoCallbackIncreaseBytes():Unit{
         if (noCallbackIncreaseBytes == 0){
            return
         }
        callbackDispatcher.dispatch().fetchProgress(task, blockIndex, noCallbackIncreaseBytes)
        noCallbackIncreaseBytes = 0
    }