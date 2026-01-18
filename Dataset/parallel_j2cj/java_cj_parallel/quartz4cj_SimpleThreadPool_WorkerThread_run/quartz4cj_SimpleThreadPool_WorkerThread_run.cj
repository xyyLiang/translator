    public func run() : Unit  {
        let ran  = Box(false)
        
        while (runFlag.load()) {
            try {
                synchronized(lock) {

                    while (!runnable.isPresent() && runFlag.load()) {
                        lock.wait(timeout: Duration.millisecond * 500);
                    }
                
                    runnable.ifPresent( { r => ran.value = true; r();  } )
                }

            } catch (exceptionInRunnable: Exception ) {
                log.error("Error while executing the Runnable: ${exceptionInRunnable.message}" , exceptionInRunnable );
            } finally {
                synchronized(lock) {
                    runnable = None;
                }

                if (runOnce) {
                    runFlag.store(false);
                    tp.clearFromBusyWorkersList(this);
                } else if(ran.value) {
                    ran.value = false;
                    tp.makeAvailable(this);
                }

            }
        }

        log.info("WorkerThread is shut down.");
    }