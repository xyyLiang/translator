    func assembleBlockAndCallbackFromBeginning(info:BreakpointInfo,remoteCheck:BreakpointRemoteCheck):Unit{
        Util.assembleBlock(task, info, remoteCheck.getInstanceLength(),remoteCheck.isAcceptRange())
        Download4cj.withs().callbackDispatcher().dispatch().downloadFromBeginning(task)
    }