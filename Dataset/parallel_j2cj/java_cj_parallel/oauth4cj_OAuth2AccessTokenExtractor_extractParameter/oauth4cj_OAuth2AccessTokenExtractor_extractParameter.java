    private static String extractParameter(String response, Pattern regexPattern, boolean required)
            throws OAuthException {

        final Matcher matcher = regexPattern.matcher(response);
        if (matcher.find()) {
            return OAuthEncoder.decode(matcher.group(1));
        } else if (required) {
            throw new OAuthException("Response body is incorrect. Can't extract a '" + regexPattern.pattern()
                    + "' from this: '" + response + "'", null);
        } else {
            return null;
        }
    }