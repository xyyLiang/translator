   public static func computeFireTimes(trigg: OperableTrigger, cal: ?Calendar, numTimes: Int64): QzLinkedList<DateTime> {
        let lst = QzLinkedList<DateTime>()

        let t = trigg.clone()

        if (!t.getNextFireTime().isPresent()) {
            t.computeFirstFireTime(cal)
        }

        for (_ in 0..numTimes ) {
            let dtOpt = t.getNextFireTime()
            if( let Some(dt) <- dtOpt ) {
                lst.append(dt)
                t.triggered(cal)
            } else {
                break;
            }
        }

        return lst
    }   