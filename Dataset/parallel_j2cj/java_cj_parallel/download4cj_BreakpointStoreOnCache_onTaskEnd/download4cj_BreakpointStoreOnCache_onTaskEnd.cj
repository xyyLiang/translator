    public func onTaskEnd(id:Int64,cause:EndCause,exception:Option<Exception>):Unit{
        if(let Some(i) <- exception){
            println("onTaskEnd exception="+i.message)
        }
        match(cause){
            case EndCause.COMPLETED =>  remove(id)
            case _ => return
        }
    }