    public func updateAfterMisfire(cal: ?Calendar): Unit {
        var instr: Int64 = getMisfireInstruction()
        
        if(instr == MISFIRE_INSTRUCTION_IGNORE_MISFIRE_POLICY) {
            return
        }

        if (instr == MISFIRE_INSTRUCTION_SMART_POLICY) {
            if (getRepeatCount() == 0) {
                instr = MISFIRE_INSTRUCTION_FIRE_NOW
            } else if (getRepeatCount() == REPEAT_INDEFINITELY) {
                instr = MISFIRE_INSTRUCTION_RESCHEDULE_NEXT_WITH_REMAINING_COUNT
            } else {
                instr = MISFIRE_INSTRUCTION_RESCHEDULE_NOW_WITH_EXISTING_REPEAT_COUNT
            }
        } else if (instr == MISFIRE_INSTRUCTION_FIRE_NOW && getRepeatCount() != 0) {
            instr = MISFIRE_INSTRUCTION_RESCHEDULE_NOW_WITH_REMAINING_REPEAT_COUNT
        }

        if (instr == MISFIRE_INSTRUCTION_FIRE_NOW) {
            setNextFireTime(DateTime.now())
        } else if (instr == MISFIRE_INSTRUCTION_RESCHEDULE_NEXT_WITH_EXISTING_COUNT) {
            var newFireTime: ?DateTime = getFireTimeAfter(DateTime.now())

            while(newFireTime != None && cal.isPresent() && !cal.getOrThrow().isTimeIncluded(newFireTime.getOrThrow().getTime())) {
                newFireTime = getFireTimeAfter(newFireTime)
                if(newFireTime == None) {
                    break
                }

                if(newFireTime.getOrThrow().year > TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT) {
                    newFireTime = None
                }
            }
            setNextFireTime(newFireTime)
        } else if (instr == MISFIRE_INSTRUCTION_RESCHEDULE_NEXT_WITH_REMAINING_COUNT) {
            var newFireTime: ?DateTime = getFireTimeAfter(DateTime.now())
            while (newFireTime != None && cal.isPresent() && !cal.getOrThrow().isTimeIncluded(newFireTime.getOrThrow().getTime())) {
                newFireTime = getFireTimeAfter(newFireTime)
                if(newFireTime == None) {
                    break
                }
                
                //avoid infinite loop
                if(newFireTime.getOrThrow().year > TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT) {
                    newFireTime = None
                }
            }
            if (newFireTime != None) {
                let timesMissed: Int64 = computeNumTimesFiredBetween(nextFireTime.getOrThrow(),
                        newFireTime.getOrThrow())
                setTimesTriggered(getTimesTriggered() + timesMissed)
            }

            setNextFireTime(newFireTime)
        } else if (instr == MISFIRE_INSTRUCTION_RESCHEDULE_NOW_WITH_EXISTING_REPEAT_COUNT) {
            var newFireTime = DateTime.now()
            if (repeatCount != 0 && repeatCount != REPEAT_INDEFINITELY) {
                setRepeatCount(getRepeatCount() - getTimesTriggered())
                setTimesTriggered(0)
            }
            
            if (getEndTime() != None && getEndTime().getOrThrow() <= newFireTime) { // quartz 原有代码这里有 bug, endTime不能是最后一次触发时间, 已修复
                setNextFireTime(None) // We are past the end time
            } else {
                setStartTime(newFireTime)
                setNextFireTime(newFireTime)
            }
        } else if (instr == MISFIRE_INSTRUCTION_RESCHEDULE_NOW_WITH_REMAINING_REPEAT_COUNT) {
            var newFireTime = DateTime.now()

            let timesMissed: Int64 = computeNumTimesFiredBetween(nextFireTime.getOrThrow(),  newFireTime)

            if (repeatCount != 0 && repeatCount != REPEAT_INDEFINITELY) {
                var remainingCount = getRepeatCount() - (getTimesTriggered() + timesMissed)
                if (remainingCount <= 0) { 
                    remainingCount = 0
                }
                setRepeatCount(remainingCount)
                setTimesTriggered(0)
            }

            if (getEndTime() != None && getEndTime().getOrThrow() <= newFireTime) { // quartz 原有代码这里有 bug, endTime不能是最后一次触发时间, 已修复
                setNextFireTime(None) // We are past the end time
            } else {
                setStartTime(newFireTime)
                setNextFireTime(newFireTime)
            } 
        }        
    }
