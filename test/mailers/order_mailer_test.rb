require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "order confirmation email" do
    # Set up an order based on the fixture
    order = orders(:one)

    # Set up an email using the order contents
    email = OrderMailer.with(order: order).order_confirmation_email

    # Check if the email is sent
    assert_emails 1 do
      email.deliver_now
    end

    # Check the contents are correct
    assert_equal [ENV['ADMIN_EMAIL']], email.from
    assert_equal [ENV['ADMIN_EMAIL']], email.to
    assert_equal "Your order is confirmed!"
  end
end
