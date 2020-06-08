class UserSkillLevelsController < ApplicationController
  def index
    render json: UserSkillLevel.all
  end

  def show
    render json: UserSkillLevel.find(params[:id])
  end
end
