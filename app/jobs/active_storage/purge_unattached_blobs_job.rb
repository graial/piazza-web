class ActiveStorage::PurgeUnattachedBlobsJob < ApplicationJob
  queue_as :default

  def perform(listing)
    ActiveStorage::Blob.unattached 
      .where("active_storage_blobs.created_at <= ?", 2.days.ago)
      .find_each(&:purge_later)
  end
end
