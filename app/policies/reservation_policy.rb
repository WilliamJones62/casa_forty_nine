# frozen_string_literal: true

# This class contains Reservation Policy logic
class ReservationPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  attr_reader :user, :reservation

  def initialize(user, reservation)
    super
    # @user = user
    @reservation = reservation
  end

  def edit?
    user.admin? || user.id == reservation.user_id
  end
end
