    public String getString(String key) {
        Object obj = get(key);
    
        try {
            return (String) obj;
        } catch (Exception e) {
            throw new ClassCastException("Identified object is not a String.");
        }
    }