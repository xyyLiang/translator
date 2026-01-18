     func determineBlockCount(task:DownloadTask,totalLengtha:Int64):Int64{
        if(let Some(i) <- task.getSetConnectionCount()){
            if(i != 0){
                return i
            }
        }
        if (totalLengtha < ONE_CONNECTION_UPPER_LIMITA) {
            return 1
        }
        if (totalLengtha < TWO_CONNECTION_UPPER_LIMITA) {
            return 2
        }
        if (totalLengtha < THREE_CONNECTION_UPPER_LIMITA) {
            return 3
        }
        if (totalLengtha < FOUR_CONNECTION_UPPER_LIMITA) {
            return 4
        }
        return 5
    }