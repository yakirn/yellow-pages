class Person < ApplicationRecord
    def self.search(params)
        query = Person.order(name: :asc)
                      .select(search_select_fields)
        query = query.where("name LIKE ?", "%#{params[:name]}%") if params[:name]
        if params[:age]
            age = Integer(params[:age], 10)
            query = query.where("age = ?", age)
        end

        query = query.where("phone LIKE ?", "%#{params[:phone]}%") if params[:phone]
        return query
    end

    private


    def self.search_select_fields
        "id, name, phone, picture, #{calc_age} AS age, printf('%s. %s, %s.', street, country, city) as address"
    end

    def self.calc_age
        "(strftime('%Y', 'now') - strftime('%Y', birthday)) - (strftime('%m-%d', 'now') < strftime('%m-%d', birthday))"
    end
end
