# frozen_string_literal: true

# This class contains Property Policy logic
class PropertyPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  attr_reader :user, :property

  def initialize(user, property)
    super
    @property = property
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end
end
