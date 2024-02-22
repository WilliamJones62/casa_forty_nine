# frozen_string_literal: true

# all services inherit from this class
class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
