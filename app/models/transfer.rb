class Transfer < ActiveRecord::Base

  belongs_to :origin,      :class_name => "Account", :foreign_key => "origin_id"
  belongs_to :destination, :class_name => "Account", :foreign_key => "destination_id"

  attr_accessible :origin_id, :origin, :destination_id, :destination, :amount, :amount_in_cents,
                  :origin_attributes, :destination_attributes

  validates_presence_of :origin_id, :destination_id, :amount_in_cents, :amount

  before_save   :patch_ensure_amounts_in_cent_is_number
  def patch_ensure_amounts_in_cent_is_number
    self.amount_in_cents= amount_in_cents.to_f
  end

  def amount
    amount_in_cents.to_i / 100.00
  end

  def amount=(value)
    self.amount_in_cents= (value * 100).to_i
  end

  def self.perform(source_account, dest_account, amount)
    tr = Transfer.new(origin: source_account, destination: dest_account, amount: amount)
    tr.save!
    tr
  end

  validate :amount_is_valid
  validate :destination_is_valid

    def amount_is_valid
      errors.add(:amount, "#{amount} is too much. Your balance is #{origin.balance}") if origin && amount > origin.balance
    end
    def destination_is_valid
      unless origin && destination && origin != destination
        errors.add(:destination, "you cannot transfer money to yourself")
      end
    end


  before_create :update_balances

  def  update_balances
    change_balance(origin,      -amount)
    change_balance(destination, amount)
  end

private

  def self.change_balance(source_account, amount)
    source_account.balance = source_account.balance + amount
    source_account.save!
  end

  def change_balance(source_account, amount)
    source_account.balance = source_account.balance + amount
    source_account.save!
  end

end
