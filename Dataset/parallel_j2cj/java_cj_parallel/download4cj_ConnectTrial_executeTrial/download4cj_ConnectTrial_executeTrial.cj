    func executeTrial():Unit{
        var connection:DownloadConnection = Download4cj.withs().connectionFactory().create(task.getUrl())
        var isNeedTrialHeadMethod:Bool = false
        try{
            connection.addHeader(Util.RANGE, "bytes=0-0")
            let userHeader:Option<HashMap<String,ArrayList<String>>> = task.getHeaderMapFields()
            if(let Some(_) <- userHeader){
                 Util.addUserRequestHeaderField(userHeader.getOrThrow(), connection)
            }
            let listener:DownloadListener = Download4cj.withs().callbackDispatcher().dispatch()
            let requestProperties:HashMap<String,ArrayList<String>> = connection.getRequestProperties()

            listener.connectTrialStart(task, requestProperties)
            let connected:DownloadConnectionConnected = connection.execute()

            if(let Some(_) <- connected.getRedirectLocation()){
                  task.setRedirectLocation(connected.getRedirectLocation().getOrThrow())
            }
            this.responseCode = connected.getResponseCode()
            this.acceptRange = isAcceptRanges(connected)
            this.instanceLength = findInstanceLength(connected)
            this.responseEtag = findEtag(connected)
            this.responseFilename = findFilename(connected)
            var responseHeader: Option<HashMap<String, ArrayList<String>>> = connected.getResponseHeaderFields()
            if(let Some(_) <- responseHeader){
            }else{
                 responseHeader = HashMap<String, ArrayList<String>>()
            }
             listener.connectTrialEnd(task, responseCode, responseHeader.getOrThrow())
             isNeedTrialHeadMethod = isNeedTrialHeadMethodForInstanceLength(instanceLength)
        }finally {
            connection.release()
        }
    }