class ApplicationSerializer < ActiveModel::Serializer
    include ActionView::Helpers::NumberHelper

    def value
        number_to_currency(object.value, unit: "R$", separator: ",", delimiter: "")        
    end

    def created_at
        object.created_at.strftime("%d/%m/%Y")
    end
end