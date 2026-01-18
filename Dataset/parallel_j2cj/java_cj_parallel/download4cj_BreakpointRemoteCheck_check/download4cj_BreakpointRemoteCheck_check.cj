    func check():Unit{
        let downloadStrategy:DownloadStrategy = Download4cj.withs().downloadStrategy()
        var connectTrial:ConnectTrial = createConnectTrial()
        connectTrial.executeTrial()
        let isAcceptRange:Bool = connectTrial.isAcceptRange()
        let isChunked:Bool = connectTrial.isChunked()

        let instanceLength:Int64 = connectTrial.getInstanceLength()
        let responseEtag:String = connectTrial.getResponseEtag()
        let responseFilename:String =  connectTrial.getResponseFilename()
        let responseCode:Int64 =  connectTrial.getResponseCode()

        downloadStrategy.validFilenameFromResponse(responseFilename, task)
        info.setChunked(isChunked)
        info.setEtag(responseEtag)

        let resumeFailedCause:Option<ResumeFailedCause> = downloadStrategy.getPreconditionFailedCause(responseCode, info.getTotalOffset() != 0, info,responseEtag)

        if(let Some(_) <- resumeFailedCause){
            this.resumable = false
        }else{
            this.resumable = true
        }
        this.failedCause = resumeFailedCause
        this.instanceLength = instanceLength
        this.acceptRange = isAcceptRange


        if (!isTrialSpecialPass(responseCode, instanceLength, resumable)) {
            if(downloadStrategy.isServerCanceled(responseCode, info.getTotalOffset() != 0)){
                throw ServerCanceledException(responseCode, info.getTotalOffset())
            }
        }
    }