class AddConfirmationEmailSentAtToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :confirmation_email_sent_at, :datetime
  end
end
