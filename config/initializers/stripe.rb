# Stripe.api_key = "sk_test_SqIGijotbCQi8pgjX8uvJ8KH"
# STRIPE_PUBLIC_KEY = "pk_test_7t0x4z5PNIl9VT5aOZGH2tsM"

Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
