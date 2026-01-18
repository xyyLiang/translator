    public void shutdown(boolean waitForJobsToComplete) {

        synchronized (nextRunnableLock) {
            getLog().debug("Shutting down threadpool...");

            isShutdown = true;

            if(workers == null) // case where the pool wasn't even initialize()ed
                return;

            // signal each worker thread to shut down
            Iterator<WorkerThread> workerThreads = workers.iterator();
            while(workerThreads.hasNext()) {
                WorkerThread wt = workerThreads.next();
                wt.shutdown();
                availWorkers.remove(wt);
            }

            // Give waiting (wait(1000)) worker threads a chance to shut down.
            // Active worker threads will shut down after finishing their
            // current job.
            nextRunnableLock.notifyAll();

            if (waitForJobsToComplete == true) {

                boolean interrupted = false;
                try {
                    // wait for hand-off in runInThread to complete...
                    while(handoffPending) {
                        try {
                            nextRunnableLock.wait(100);
                        } catch(InterruptedException e) {
                            interrupted = true;
                        }
                    }

                    // Wait until all worker threads are shut down
                    while (busyWorkers.size() > 0) {
                        WorkerThread wt = (WorkerThread) busyWorkers.getFirst();
                        try {
                            getLog().debug(
                                    "Waiting for thread " + wt.getName()
                                            + " to shut down");

                            // note: with waiting infinite time the
                            // application may appear to 'hang'.
                            nextRunnableLock.wait(2000);
                        } catch (InterruptedException e) {
                            interrupted = true;
                        }
                    }

                    workerThreads = workers.iterator();
                    while(workerThreads.hasNext()) {
                        WorkerThread wt = (WorkerThread) workerThreads.next();
                        try {
                            wt.join();
                            workerThreads.remove();
                        } catch (InterruptedException e) {
                            interrupted = true;
                        }
                    }
                } finally {
                    if (interrupted) {
                        Thread.currentThread().interrupt();
                    }
                }

                getLog().debug("No executing jobs remaining, all threads stopped.");
            }
            getLog().debug("Shutdown of threadpool complete.");
        }
    }
