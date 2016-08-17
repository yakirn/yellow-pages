class PeopleController < ApplicationController
  before_action :set_person, only: [:show]

  # GET /people/1
  def show
    render json: @person
  end

  def search
      query = Person.order(name: :asc)
                    .select(search_select_fields)
      query = query.where("name LIKE ?", "%#{params[:name]}%") if params[:name]
      if params[:age]
          age = Integer(params[:age], 10)
          query = query.where("age = ?", age)
      end
      query = query.where("phone LIKE ?", "%#{params[:phone]}%") if params[:phone]
      #TODO: handle a case where no name, age, or phone were given
      res = query.to_a
      render json: {total: res.length, people: res.first(20)}
  end

  private

    def search_select_fields
        "id, name, phone, picture, #{calc_age} AS age, printf('%s. %s, %s.', street, country, city) as address"
    end

    def calc_age
        "(strftime('%Y', 'now') - strftime('%Y', birthday)) - (strftime('%m-%d', 'now') < strftime('%m-%d', birthday))"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def person_params
      params.require(:person).permit(:name, :birthday, :phone, :picture, :country, :city, :street)
    end
end
