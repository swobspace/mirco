module Mirco
  class PurgeTimescaleJob < ApplicationJob
    queue_as :default

    def perform(*args)
      ApplicationRecord.connection.execute <<-END_OF_SQL
        SELECT drop_chunks('channel_counters', INTERVAL '6 weeks');
      END_OF_SQL
    end
  end
end
