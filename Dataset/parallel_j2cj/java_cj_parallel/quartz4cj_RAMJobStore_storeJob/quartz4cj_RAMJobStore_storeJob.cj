    public func storeJob(newJob: JobDetail, replaceExisting: Bool ) : Unit  {
        let jw = JobWrapper(newJob.clone());

        var repl = false;

        synchronized (lock) {
            if (jobsByKey.contains(jw.key)) {
                if (!replaceExisting) {
                    throw ObjectAlreadyExistsException(newJob);
                }
                repl = true;
            }

            if (!repl) {
                // get job group
                var grpMapOpt = jobsByGroup.get(newJob.getKey().getGroup());
                match( grpMapOpt ) {
                    case Some(grpMap) => 
                        grpMap.put(newJob.getKey(), jw);
                    case None =>
                        let grpMap = HashMap<JobKey, JobWrapper>(100);
                        jobsByGroup.put(newJob.getKey().getGroup(), grpMap);
                        grpMap.put(newJob.getKey(), jw);
                }
                // add to jobs by FQN map
                jobsByKey.put(jw.key, jw);
            } else {
                // update job detail
                let orig = jobsByKey.get(jw.key).getOrThrow()
                orig.jobDetail = jw.jobDetail; // already cloned
            }
        }
    }