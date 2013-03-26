class Transfer < ActiveRecord::Base
  class Error < RuntimeError; end
  class InvalidAmountError        < Transfer::Error; end
  class InvalidDestinationError   < Transfer::Error; end

  belongs_to :origin
  belongs_to :destination
  attr_accessible :origin_id, :destination_id, :amount, :amount_in_cents

  def amount
    amount_in_cents / 100.00
  end

  def amount=(value)
    self.amount_in_cents= (value * 100).to_i
  end

  def self.perform(source_account, dest_account, amount)
    validate_transfer_parameters!(source_account, dest_account, amount)
    change_balance(source_account, -amount)
    change_balance(dest_account,    amount)
    create!(origin_id: source_account.id, destination_id: dest_account.id, amount: amount)
  end

private

  def self.validate_transfer_parameters!(source_account, dest_account, amount)
    if (source_account == dest_account) || (!source_account.is_a?(Account)) || (!dest_account.is_a?(Account))
      raise InvalidDestinationError
    end
    if amount < 0 || amount > source_account.balance
      raise InvalidAmountError
    end
  end

  def self.change_balance(source_account, amount)
    source_account.balance = source_account.balance + amount
    source_account.save!
  end

end
