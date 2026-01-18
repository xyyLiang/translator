    private func inspectTaskEnd(cause:EndCause,realCause:Option<Exception>){

        synchronized(m){
            if (canceled){
                return
            }
            finishing = true
        }
        store.onTaskEnd(task.getId(), cause, realCause)
        match(cause){
            case EndCause.COMPLETED =>
                store.markFileClear(task.getId())
            case _ =>  println("cause not complete")
        }
        Download4cj.withs().callbackDispatcher().dispatch().taskEnd(task, realCause)

    }