class DataHandler
  def initialize key
    @key = key
  end

  class << self
    def all
      # class level all
      resulted_records = []

      User.in_batches(of: 1000).each do |user|
        data_handler = self.new(user.id)
        # check for existence
        next unless exists?

        # pushed to collection array
        resulted_records.push(data_handler.get_records)

        # releasing reference
        data_handler = nil
      end

      resulted_records
    end

  end

# instance methods
  def all
    return [] unless exists?

    get_records
  end

  def where opts={}
    return [] unless exists?

    resulted_records = []
    get_records.each do |data|
      # reset flag
      outer_break_status = false
      opts.keys.each do |key|
        # downcase for make it non case sensitive
        unless data[key.to_s].to_s.downcase.include? opts[key].to_s.downcase
          # skip the outer loop if one of the match is failed.
          outer_break_status = true
          break
        end
      end

      next if outer_break_status
      resulted_records.push(data)
    end

    resulted_records
  end

  def find_by_address opts={}
    return [] unless exists?

    resulted_records = []
    get_records.each do |data|
      # reset flag
      outer_break_status = false
      opts.keys.each do |key|
        # downcase for make it non case sensitive
        unless data['address'][key.to_s].to_s.downcase.include? opts[key].to_s.downcase
          # skip the outer loop if one of the match is failed.
          outer_break_status = true
          break
        end
      end

      next if outer_break_status
      resulted_records.push(data)
    end

    resulted_records
  end

  def exists?
    $redis.exists(@key)
  end

  def get_records
    data = $redis.get(@key) || []

    ActiveSupport::JSON.decode data
  end

end


    # opts.keys.each do |key|
    #   # handle for malicious keys
    #   next unless data[key].present?

    #   if data[key].kind_of Hash

    #   elsif data[key].kind_of Array

    #   else
    #     # String, Integer, Flaot and  Double
    #     p "==========#{data[key]} -===== #{opts[key]}"
    #     resulted_records.push() if data[key] == opts[key]
    #   end
    # end
