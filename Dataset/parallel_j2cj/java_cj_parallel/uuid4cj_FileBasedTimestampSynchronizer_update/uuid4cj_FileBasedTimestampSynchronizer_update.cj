    public func update(now:Int64):Int64 {
        let nextAllowed: Int64 = now + mInterval
        if (mFirstActive) {
            mLocked2.writeStamp(nextAllowed)
        } else {
            mLocked1.writeStamp(nextAllowed);
        }
        mFirstActive = !mFirstActive
        return nextAllowed
    }