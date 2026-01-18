    func cancel():Unit{
        if (finished.load()){
            return
        }
        //java这边有个线程interrupt，仓颉则没有
    }