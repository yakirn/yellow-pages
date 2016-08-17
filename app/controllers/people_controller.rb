class PeopleController < ApplicationController
  before_action :set_person, only: [:show]

  # GET /people/1
  def show
    render json: @person
  end

  # GET /people/search?name=abc%age=30&phone=12345&limit=100
  # Query the first 2000 results
  # returns to the client maximun of 100 results or the limit arg, if specified.
  # this is instead of implementing a pagination mechanisem.
  def search
      if !(params[:name] || params[:phone] || params[:age])
          res =  []
      else
          query = Person.search params
          res = query.take Rails.configuration.search['search_query_limit']
      end
      res_limit = limit params[:limit]
      render json: {
          total: res.length,
          people: res_limit < res.length ? res.first(res_limit) : res
      }
  end

  private
    def limit(limit)
      limit = limit.to_i
      if limit == 0 then Rails.configuration.search['search_limit_param_default']
      else limit
      end
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
