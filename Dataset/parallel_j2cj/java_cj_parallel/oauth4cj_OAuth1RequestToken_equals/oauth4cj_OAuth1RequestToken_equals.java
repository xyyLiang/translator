    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final OAuth1RequestToken other = (OAuth1RequestToken) obj;
        if (oauthCallbackConfirmed != other.isOauthCallbackConfirmed()) {
            return false;
        }
        if (!Objects.equals(getToken(), other.getToken())) {
            return false;
        }
        return Objects.equals(getTokenSecret(), other.getTokenSecret());
    }