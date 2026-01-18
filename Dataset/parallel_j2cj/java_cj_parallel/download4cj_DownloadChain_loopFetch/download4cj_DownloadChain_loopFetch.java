public long loopFetch() throws IOException {
    if (fetchIndex == fetchInterceptorList.size()) {
        // last one is fetch data interceptor
        fetchIndex--;
    }
    return processFetch();
