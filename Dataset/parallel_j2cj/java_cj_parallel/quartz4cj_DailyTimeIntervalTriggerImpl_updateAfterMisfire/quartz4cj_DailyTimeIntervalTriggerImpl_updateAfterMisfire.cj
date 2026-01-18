    public override func updateAfterMisfire(cal: ?Calendar): Unit {
        var instr = getMisfireInstruction()
        if(instr == MISFIRE_INSTRUCTION_IGNORE_MISFIRE_POLICY) {
            return
        }

        if (instr == MISFIRE_INSTRUCTION_SMART_POLICY) {
            instr = MISFIRE_INSTRUCTION_FIRE_ONCE_NOW
        }

        if (instr == MISFIRE_INSTRUCTION_DO_NOTHING) {
            var newFireTime = getFireTimeAfter(DateTime.now())
            while (newFireTime.isPresent() && cal.isPresent() && !cal.getOrThrow().isTimeIncluded(newFireTime.getOrThrow().getTime())) {
                newFireTime = getFireTimeAfter(newFireTime)
            }
            setNextFireTime(newFireTime)
        } else if (instr == MISFIRE_INSTRUCTION_FIRE_ONCE_NOW) { 
            // fire once now...
            setNextFireTime(DateTime.now())
            // the new fire time afterward will magically preserve the original  
            // time of day for firing for day/week/month interval triggers, 
            // because of the way getFireTimeAfter() works - in its always restarting
            // computation from the start time.
        }
    } 