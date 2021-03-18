module BankTransactionsHelper
    def get_banks
        Bank.all.map { |b| ["#{b.name} - #{b.code}", b.id] }
    end
end
