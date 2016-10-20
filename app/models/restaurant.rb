class Restaurant

  class << self
    def all
      key = 1
      DataHandler.new(key).all
    end

    def where opts={}
      key = 1
      DataHandler.new(key).where opts
    end
  end
end
