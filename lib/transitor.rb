require "transitor/version"
require "transitor/base"
require "transitor/transition_error"

module Transitor
  def method_missing(name, *args, &block)
    indicator = name.to_s.scan(/can_(\w+)?/).flatten.compact
    if indicator.present? && klass = transition_klass(indicator[0])
      return klass.new(self).can?
    end
    action = name.to_s.scan(/(\w+)!/).flatten.compact
    if action.present? && klass = transition_klass(action[0])
      return klass.new(self).perform
    end
    super
  end

  def transition_klass(name)
    "#{transition_module}::#{name.camelize}".safe_constantize
  end

  def transition_module
    "#{self.class.name}Transitions"
  end
end
