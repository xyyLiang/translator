   public static func computeFireTimesBetween(trigg: OperableTrigger, cal: ?Calendar, 
        froms: DateTime, to: DateTime): QzLinkedList<DateTime> {
                
        let lst = QzLinkedList<DateTime>()
        
        let t = trigg.clone()

        if (!t.getNextFireTime().isPresent()) {
            t.setStartTime(froms)
            t.setEndTime(to)
            t.computeFirstFireTime(cal)
        }

        while (true) {
            let dtOpt = t.getNextFireTime()
            if( let Some(d) <- dtOpt ) {
                if (d < froms) {
                    t.triggered(cal)
                    continue
                }
                if (d > to) {
                    break
                }
                lst.append(d)
                t.triggered(cal)
            } else {
                break
            }
        }

        return lst
    }