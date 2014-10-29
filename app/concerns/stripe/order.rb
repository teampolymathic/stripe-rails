module Stripe
  # Stripe Orders have:
  #
  # stripe_charge_id
  # - the individual charge that settled this order
  # stripe_card_token
  # - the card used to pay for this order
  # customer
  # - the user object (in a devise setup, probably a User model
  #   object) which bought this order

  module Order
    extend ActiveSupport::Concern
    def customer
      self.respond_to?(:user) ? user : super
    end

    def stripe_charge
      return unless stripe_charge_id
      Stripe::Charge.retrieve(stripe_charge_id)
    end
    alias :charge :stripe_charge

    def card
      if stripe_charge
        stripe_charge.card
      else
        return unless stripe_card_token
        Stripe::Card.retrieve(stripe_card_token)
      end
    end
  end
end
