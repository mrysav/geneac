# frozen_string_literal: true

# User profile display controller
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
end
