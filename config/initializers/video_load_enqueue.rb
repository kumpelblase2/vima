ActiveSupport.on_load(:after_initialize, yield: true) {
  VideoLoadJob.perform_now
  CleanupJob.perform_later
  ThumbnailGeneratorJob.perform_now
}