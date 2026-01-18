    func isInterrupt():Bool{
         return preconditionFailed || userCanceled || serverCanceled || unknownError|| fileBusyAfterRun || preAllocateFailed
    }