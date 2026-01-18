    public init(lockFile1: File, lockFile2: File, interval: Int64){
        mInterval = interval
        mLocked1 = LockedFile(lockFile1)

        var ok: Bool = false
        try {
         mLocked2 = LockedFile(lockFile2)
         ok = true
        } finally {
            if (!ok) {
               mLocked1.deactivate()
            }
        }
    }