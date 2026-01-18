    public static OAuth2Error parseFrom(String errorString) {
        for (OAuth2Error error : VALUES) {
            if (error.errorString.equals(errorString)) {
                return error;
            }
        }
        throw new IllegalArgumentException("there is no knowlege about '" + errorString + "' Error");
    }