    public boolean isInterrupt() {
        return preconditionFailed || userCanceled || serverCanceled || unknownError
                || fileBusyAfterRun || preAllocateFailed;
    }