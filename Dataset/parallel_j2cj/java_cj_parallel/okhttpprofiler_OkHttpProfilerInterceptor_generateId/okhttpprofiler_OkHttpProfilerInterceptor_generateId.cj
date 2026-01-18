    private func generateId():String {
        synchronized(mtx) {

            var currentTime: Int64 = Time.now().unixNano()/1000

            var previousTime: Int64 = mPreviousTime.load()
            if(currentTime <= previousTime){
                previousTime++
                currentTime = previousTime
            }
            mPreviousTime.store(currentTime)
            return currentTime.toString()
        }
    }