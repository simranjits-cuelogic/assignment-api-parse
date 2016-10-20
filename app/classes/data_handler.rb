class DataHandler
  def initialize key
    @key = key
  end

  # class << self
  #   def all
  #     # class level all
  #   end

  #   def where(opts = :chain, *rest)
  #     if opts == :chain
  #       WhereChain.new(spawn)
  #     elsif opts.blank?
  #       self
  #     else
  #       spawn.where!(opts, *rest)
  #     end
  #   end
  # end

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
        # p "=====keys====> #{key} =====#{data[key.to_s].class} -- #{opts[key].class}"
        # not for array element, not for Hash
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