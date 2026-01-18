    public func getSummary() : String {

        let remoteStr = if( remote ) { "- access remote" } else  { "- running locally" }

        let stateStr = match( (shutdown,startTime) ) {
            case (true,_) => "Scheduler has been SHUTDOWN"
            case (_,Some(dt)) => "Running since ${dt}"
            case (_,None) => "NOT STARTED"
        }

        let modeStr = if( inStandbyMode ) { "Currently in standby mode" } else  { "Not Currently in standby mode" }
        let persistStr = if( jsPersistent ) { "supports persistence" } else  { "does not support persistence" }
        let clusterStr = if( jsClustered ) { "and is clustered" } else  { "and is not clustered" }

        return "Quartz Scheduler (v${version}) '${schedName}' '${schedInst}'.\n" +
                "  Scheduler class: '${schedClass}' ${remoteStr}.\n" +
                "  ${stateStr}.\n" +
                "  ${modeStr}.\n" +
                "  Number of jobs executed: ${numJobsExec}.\n" +
                "  Using thread pool: '${tpClass}' - with ${tpSize} threads.\n" +
                "  Using job-store: '${jsClass}' - which ${persistStr} ${clusterStr}.\n";
    }
