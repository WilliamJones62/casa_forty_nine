# frozen_string_literal: true

# This class contains Review Policy logic
class ReviewPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  attr_reader :user, :review

  def initialize(user, review)
    super
    @review = review
  end

  def edit?
    user.admin? || user.id == review.user_id
  end
end
