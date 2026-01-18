    public func shutdown(waitForJobsToComplete: Bool ) : Unit {

        synchronized (nextRunnableLock) {
            
            log.info("Shutting down threadpool...");

            isShutdown = true;

            if(workers.isEmpty()) { // case where the pool wasn't even initialize()ed
                return;
            }

            // signal each worker thread to shut down
            for( wt in workers) {
                wt.shutdown();
                availWorkers.remove(wt);
            }

            // Give waiting (wait(1000)) worker threads a chance to shut down.
            // Active worker threads will shut down after finishing their
            // current job.
            nextRunnableLock.notifyAll();

            if (waitForJobsToComplete == true) {
                 

                // wait for hand-off in runInThread to complete...
                while(handoffPending) {
                    nextRunnableLock.wait(timeout: Duration.millisecond * 100);
                }

                // Wait until all worker threads are shut down
                while (busyWorkers.size > 0) {
                    let wtOpt = busyWorkers.getFirst();
                    let wt = wtOpt.getOrThrow()
                    if( log.isDebugEnabled()) {
                        log.debug("Waiting for thread " + wt.getName() + " to shut down");
                    }
                    // note: with waiting infinite time the application may appear to 'hang'.
                    nextRunnableLock.wait(timeout: Duration.millisecond * 2000);
                }

                for( wt in workers ) {
                    wt.join();
                }

                workers.clear()

                log.info("No executing jobs remaining, all threads stopped.");
            }

            log.info("Shutdown of threadpool complete.");
        }
    }