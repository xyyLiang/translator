    private synchronized String generateId() {
        long currentTime = Long.parseLong(format.format(new Date()));
        //Increase time if it the same, as previous (unique id)
        long previousTime = this.previousTime.get();
        if(currentTime <= previousTime) {
            currentTime = ++previousTime;
        }
        this.previousTime.set(currentTime);
        return Long.toString(currentTime, Character.MAX_RADIX);
    }