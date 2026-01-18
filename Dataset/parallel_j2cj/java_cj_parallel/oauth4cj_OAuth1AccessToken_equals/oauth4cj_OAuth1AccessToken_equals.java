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
        final OAuth1AccessToken other = (OAuth1AccessToken) obj;
        if (!Objects.equals(getToken(), other.getToken())) {
            return false;
        }
        return Objects.equals(getTokenSecret(), other.getTokenSecret());
    }