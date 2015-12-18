class Campaign
  include Transitor
  attr_accessor :state
  attr_accessor :history

  def initialize(state = :draft)
    @state = state
    @history = []
  end
end


