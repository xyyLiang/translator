    public void setDaysExcluded(ArrayList<java.util.Calendar> days) {
        if (days == null) {
            excludeDays = new ArrayList<java.util.Calendar>();
        } else {
            excludeDays = days;
        }

        dataSorted = false;
    }