    public void executeTrial() throws IOException {
        OkDownload.with().downloadStrategy().inspectNetworkOnWifi(task);
        OkDownload.with().downloadStrategy().inspectNetworkAvailable();

        DownloadConnection connection = OkDownload.with().connectionFactory().create(task.getUrl());
        boolean isNeedTrialHeadMethod;
        try {
            if (!Util.isEmpty(info.getEtag())) {
                connection.addHeader(IF_MATCH, info.getEtag());
            }
            connection.addHeader(RANGE, "bytes=0-0");
            final Map<String, List<String>> userHeader = task.getHeaderMapFields();
            if (userHeader != null)  Util.addUserRequestHeaderField(userHeader, connection);

            final DownloadListener listener = OkDownload.with().callbackDispatcher().dispatch();
            final Map<String, List<String>> requestProperties = connection.getRequestProperties();
            listener.connectTrialStart(task, requestProperties);

            final DownloadConnection.Connected connected = connection.execute();
            task.setRedirectLocation(connected.getRedirectLocation());
            Util.d(TAG, "task[" + task.getId() + "] redirect location: "
                    + task.getRedirectLocation());

            this.responseCode = connected.getResponseCode();
            this.acceptRange = isAcceptRange(connected);
            this.instanceLength = findInstanceLength(connected);
            this.responseEtag = findEtag(connected);
            this.responseFilename = findFilename(connected);
            Map<String, List<String>> responseHeader = connected.getResponseHeaderFields();
            if (responseHeader == null) responseHeader = new HashMap<>();
            listener.connectTrialEnd(task, responseCode, responseHeader);

            isNeedTrialHeadMethod = isNeedTrialHeadMethodForInstanceLength(instanceLength,
                    connected);
        } finally {
            connection.release();
        }

        if (isNeedTrialHeadMethod) {
            trialHeadMethodForInstanceLength();
        }
    }