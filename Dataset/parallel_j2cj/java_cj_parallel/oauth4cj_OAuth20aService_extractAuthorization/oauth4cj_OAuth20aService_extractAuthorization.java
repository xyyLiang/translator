    public OAuth2Authorization extractAuthorization(String redirectLocation) {
        final OAuth2Authorization authorization = new OAuth2Authorization();
        int end = redirectLocation.indexOf('#');
        if (end == -1) {
            end = redirectLocation.length();
        }
        for (String param : redirectLocation.substring(redirectLocation.indexOf('?') + 1, end).split("&")) {
            final String[] keyValue = param.split("=");
            if (keyValue.length == 2) {
                try {
                    switch (keyValue[0]) {
                        case "code":
                            authorization.setCode(URLDecoder.decode(keyValue[1], "UTF-8"));
                            break;
                        case "state":
                            authorization.setState(URLDecoder.decode(keyValue[1], "UTF-8"));
                            break;
                        default: //just ignore any other param;
                    }
                } catch (UnsupportedEncodingException ueE) {
                    throw new IllegalStateException("jvm without UTF-8, really?", ueE);
                }
            }
        }
        return authorization;
    }