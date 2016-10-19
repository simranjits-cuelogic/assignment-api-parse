module RedisStorable
  extend ActiveSupport::Concern

  included do
  end

  def get_records
    data = $redis.get(self.id) || []

    ActiveSupport::JSON.decode data
  end

  def set_records data
    $redis.set(self.id, data.to_json)
  end

  def exist_records?
    $redis.exists(self.id)
  end

  module ClassMethods

  end
end