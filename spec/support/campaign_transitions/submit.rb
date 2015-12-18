module CampaignTransitions
  class Submit < Transitor::Base
    def before_transition
      object.history << :before
    end

    def transition
      object.state = :submitted
      object.history << :transition
    end

    def can?
      object.state != :submitted
    end

    def guarded_message
      "Already Submitted"
    end

    def after_transition
      object.history << :after
    end
  end
end

