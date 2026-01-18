    public BasicHeaderElement(String name, String value, NameValuePair[] parameters) {
        if (name == null) {
            throw new IllegalArgumentException("Name may not be null");
        } else {
            this.name = name;
            this.value = value;
            if (parameters != null) {
                this.parameters = parameters;
            } else {
                this.parameters = new NameValuePair[0];
            }

        }
    }