class PagseguroHistory < ApplicationRecord
	belongs_to :recharge

	enum status: %i[awaiting_payment in_analysis paid available in_dispute returned canceled]
	
	def self.generate(recharge)
		history = PagseguroHistory.new
		history.recharge = recharge
		history.status = recharge.pagseguro_status
		history if history.save
	end
end
