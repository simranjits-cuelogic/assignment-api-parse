class Restaurant

  class << self
    def all key
      DataHandler.new(key).all
    end

    def where key, opts={}
      DataHandler.new(key).where opts
    end

    def find_by_address key, opts={}
      DataHandler.new(key).where opts
    end

    def all_restaurants
      DataHandler.all
    end
  end
end
