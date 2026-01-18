    private func validate(): Unit {
        if(hour < 0 || hour > 23) {
            throw IllegalArgumentException("Hour must be from 0 to 23")
        }
        if(minute < 0 || minute > 59) {
            throw IllegalArgumentException("Minute must be from 0 to 59")
        }
        if(second < 0 || second > 59) {
            throw IllegalArgumentException("Second must be from 0 to 59")
        }
    }    