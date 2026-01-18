    @Override
    public String extract(OAuthRequest request) {
        checkPreconditions(request);
        final Map<String, String> parameters = request.getOauthParameters();

        final StringBuilder header = new StringBuilder(PREAMBLE);

        for (Map.Entry<String, String> parameter : parameters.entrySet()) {
            if (header.length() > PREAMBLE.length()) {
                header.append(PARAM_SEPARATOR);
            }
            header.append(parameter.getKey())
                    .append("=\"")
                    .append(OAuthEncoder.encode(parameter.getValue()))
                    .append('"');
        }

        if (request.getRealm() != null && !request.getRealm().isEmpty()) {
            header.append(PARAM_SEPARATOR)
                    .append(OAuthConstants.REALM)
                    .append("=\"")
                    .append(request.getRealm())
                    .append('"');
        }
        return header.toString();
    }