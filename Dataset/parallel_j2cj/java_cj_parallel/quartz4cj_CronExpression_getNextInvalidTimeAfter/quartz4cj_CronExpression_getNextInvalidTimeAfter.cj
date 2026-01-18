    public func getNextInvalidTimeAfter(date0: DateTime): DateTime {

        // move back to the nearest second so differences will be accurate
        var lastDate = resetMillis(date0)
        
        var difference = 1000
        
        // keep getting the next included time until it's farther than one second
        // apart. At that point, lastDate is the last valid fire time. We return
        // the second immediately following it.
        while (difference == 1000) {
            let nextTime = getTimeAfter(lastDate)

            if( let Some(nd) <- nextTime ) {
                difference = (nd - lastDate).toMilliseconds()

                if (difference == 1000) {
                    lastDate = nd
                }
            } else {
                break
            }

        }
        
        return lastDate.addSeconds(1)
    } 