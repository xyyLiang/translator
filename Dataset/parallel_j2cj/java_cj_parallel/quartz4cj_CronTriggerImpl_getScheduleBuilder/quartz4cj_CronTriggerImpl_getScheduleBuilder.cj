    public func getScheduleBuilder(): ScheduleBuilder {
        let cb = CronScheduleBuilder.cronSchedule(getCronExpression()).inTimeZone(getTimeZone())
        
        let misfireInstruction = getMisfireInstruction()
        match(misfireInstruction) {
            case v where v == MISFIRE_INSTRUCTION_DO_NOTHING => cb.withMisfireHandlingInstructionDoNothing()
            case v where v == MISFIRE_INSTRUCTION_FIRE_ONCE_NOW => cb.withMisfireHandlingInstructionFireAndProceed()
            case v where v == MISFIRE_INSTRUCTION_IGNORE_MISFIRE_POLICY => cb.withMisfireHandlingInstructionIgnoreMisfires()
            case _ => ()
        }
        
        return cb
    }