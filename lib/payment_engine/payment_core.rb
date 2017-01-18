module PaymentCore
  def self.is_pay_success?(code)
    code == ErrorCodes::PAYMENT_SUCCESS
  end

  def self.pay_money(user_acccount_id:, amount:)
    code = Wallet.new(user_acccount_id: user_acccount_id, amount: amount).pay

    [code, error_msg(code)]
  end

  def self.error_msg(code)
    I18n.t("payment_core.error_msg.#{code}")
  end

  class Wallet
    def initialize(amount:, user_acccount_id:)
      @amount = amount
      @user_account = UserAccount.find(user_acccount_id)
    end

    def pay
      _new_account = @user_account.amount - @amount
      if _new_account >= 0
        @user_account.amount= _new_account
        if @user_account.save
          ErrorCodes::PAYMENT_SUCCESS
        else
          ErrorCodes::PAYMENT_FAILS
        end
      else
        ErrorCodes::PAYMENT_INSUFFICIENT_FUNDS
      end
    end
  end
end
