ActiveSupport.on_load(:after_initialize, yield: true) {
  VideoLoadJob.perform_later
  CleanupJob.perform_later
}
