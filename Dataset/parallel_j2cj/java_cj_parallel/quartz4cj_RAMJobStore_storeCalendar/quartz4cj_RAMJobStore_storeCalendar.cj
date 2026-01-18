    public func storeCalendar( name: String, calendar0: Calendar,  
                                replaceExisting : Bool , updateTriggers : Bool ) : Unit {

        let calendar = calendar0.clone();
        
        synchronized (lock) {
    
            let objOpt = calendarsByName.get(name);
    
            if( objOpt.isPresent() ) {
                if (!replaceExisting) {
                    throw ObjectAlreadyExistsException(  "Calendar with name '" + name + "' already exists.");
                } else {
                    calendarsByName.remove(name);
                }
            }  
            
            calendarsByName.put(name, calendar);
    
            if( objOpt.isPresent() && updateTriggers) {
                for (tw in getTriggerWrappersForCalendar(name)) {
                    let trig = tw.getTrigger();
                    let removed = timeTriggers.remove(tw);

                    trig.updateWithNewCalendar(calendar, getMisfireThreshold());

                    if (removed) {
                        timeTriggers.put(tw);
                    }
                }
            }
        }
    }
