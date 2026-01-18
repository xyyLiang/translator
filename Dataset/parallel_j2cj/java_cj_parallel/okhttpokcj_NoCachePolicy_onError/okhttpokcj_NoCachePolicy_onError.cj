    public func onError(error: okhttp_okcj.Response): Unit {
        spawn {
            mCallback.onError(error)
            mCallback.onFinish()
        }
    }