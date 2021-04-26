class Api::V1::SalariesController < ApplicationController
  def index
    if !salary_params[:location].blank?
      salaries_object = SalariesFacade.make_salary_object(salary_params[:location])
      render json: SalariesSerializer.new(salaries_object), status: 200
    else
      render json: "please enter a valid city" , status: 422
    end
  end

  private

  def salary_params
    params.permit(:location)
  end
end
