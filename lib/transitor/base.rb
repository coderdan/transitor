# Execution Flow
# - can?
# - before_transition
# - transition
# - after_transition

module Transitor
  class Base
    GUARD_MESSAGE = "Cannot transition to new state"
    attr_reader :object

    def initialize(object)
      @object = object
    end

    def perform
      do_atomically do
        raise_if_guarded!
        before_transition
        transition
        after_transition
      end
    end

    def raise_if_guarded!
      raise TransitionError, guarded_message unless can?
    end

    def can?
      true
    end

    def guarded_message
      GUARD_MESSAGE
    end

    def before_transition; end
    def after_transition; end

    private
      def do_atomically
        if defined?(ActiveRecord) && object.is_a?(ActiveRecord::Base)
          ActiveRecord::Base.transaction { yield }
        else
          yield
        end
      end
  end
end
