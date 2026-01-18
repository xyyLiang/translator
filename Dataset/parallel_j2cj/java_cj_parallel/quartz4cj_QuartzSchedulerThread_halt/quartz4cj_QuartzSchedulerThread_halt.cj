    func halt(wait: Bool) : Unit  {
        synchronized (sigLock) {
            halted.store(true);

            if (paused) {
                sigLock.notifyAll();
            } else {
                signalSchedulingChange(0);
            }
        }

        // cj 里没有 interrupt 功能, 大幅简化

        if (wait) {
            join();
        }

    }