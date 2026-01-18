    public func updateAfterMisfire(cal: ?Calendar): Unit {
        var instr: Int64 = getMisfireInstruction()

        if(instr == MISFIRE_INSTRUCTION_IGNORE_MISFIRE_POLICY) {
            return 
        }

        if (instr == MISFIRE_INSTRUCTION_SMART_POLICY) {
            instr = MISFIRE_INSTRUCTION_FIRE_ONCE_NOW
        }

        if (instr == MISFIRE_INSTRUCTION_DO_NOTHING) {
            var newFireTime: ?DateTime = getFireTimeAfter(DateTime.now(timeZone: getTimeZone()))
            while(newFireTime != None && cal.isPresent() && !cal.getOrThrow().isTimeIncluded(newFireTime.getOrThrow().getTime())) {
                newFireTime = getFireTimeAfter(newFireTime)
            }
            setNextFireTime(newFireTime)
        } else if (instr == MISFIRE_INSTRUCTION_FIRE_ONCE_NOW) {
            setNextFireTime(DateTime.now(timeZone: getTimeZone()))
        }
    }    