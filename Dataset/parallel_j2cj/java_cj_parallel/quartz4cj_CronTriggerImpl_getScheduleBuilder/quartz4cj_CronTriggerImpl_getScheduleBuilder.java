    @Override
    public ScheduleBuilder<CronTrigger> getScheduleBuilder() {
        
        CronScheduleBuilder cb = CronScheduleBuilder.cronSchedule(getCronExpression())
                .inTimeZone(getTimeZone());

        int misfireInstruction = getMisfireInstruction();
        switch(misfireInstruction) {
            case MISFIRE_INSTRUCTION_SMART_POLICY:
                break;
            case MISFIRE_INSTRUCTION_DO_NOTHING:
                cb.withMisfireHandlingInstructionDoNothing();
                break;
            case MISFIRE_INSTRUCTION_FIRE_ONCE_NOW:
                cb.withMisfireHandlingInstructionFireAndProceed();
                break;
            case MISFIRE_INSTRUCTION_IGNORE_MISFIRE_POLICY:
                cb.withMisfireHandlingInstructionIgnoreMisfires();
                break;
            default:
                LOGGER.warn("Unrecognized misfire policy {}. Derived builder will use the default cron trigger behavior (MISFIRE_INSTRUCTION_FIRE_ONCE_NOW)", misfireInstruction);
        }
        
        return cb;
    }