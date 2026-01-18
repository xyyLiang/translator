    @Override
    public void onTaskEnd(int id, @NonNull EndCause cause, @Nullable Exception exception) {
        if (cause == EndCause.COMPLETED) {
            remove(id);
        }
    }