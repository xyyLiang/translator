    @Override
    public void onResponseReceived(final RequestStats requestStats) {
        if (Utils.isLoggingEnabled) {
            Log.d("Response Received : ", requestStats + " ");
        }

        //call all the registered listeners
        for (OnResponseListener onResponseListener : mOnResponseListeners) {
            if (onResponseListener != null) {
                onResponseListener.onResponseSuccess(getActiveNetworkInfo(), requestStats);
            }
        }

        //save to shared prefs if condition is satisfied
        synchronized (this) {
            mResponseCount += 1;
            if (mResponseCount >= MAX_SIZE) {
                //calculate the new average speed
                double newAvgSpeed = mNetworkStat.mCurrentAvgSpeed;
                mCurrentAvgSpeed = (float) ((mCurrentAvgSpeed + newAvgSpeed) / 2);
                //calculate the new connection quality
                mConnectionQuality = ConnectionQuality.getConnectionQualityFromSpeed((int) mCurrentAvgSpeed);
                //save it in shared preference
                String networkKey = getNetworkKey(getActiveNetworkInfo());
                mPreferenceManager.setAverageSpeed(networkKey, mCurrentAvgSpeed);
                //reset the response count
                mResponseCount = 0;
            }
        }

        mNetworkStat.addRequestStat(requestStats);
    }