class HomeController < ApplicationController
  before_action :authenticate_student!

  def index
    @student = current_student
  end
end
