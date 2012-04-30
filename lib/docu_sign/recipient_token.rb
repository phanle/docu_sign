module DocuSign
  class RecipientToken < DocuSignModel
    attr_reader :url
    def initialize(url)
      @url = url
    end
  end
end
