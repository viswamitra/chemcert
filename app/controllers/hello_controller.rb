class HelloController < ApplicationController
  before_filter :authenticate_user!
  def hi

  end
end
