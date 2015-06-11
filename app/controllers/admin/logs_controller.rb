class Admin::LogsController < ApplicationController
  before_filter :authenticate_admin!
  # GET /logs
  def index
    if params[:type].present?
      @logs = Log.in(type: [ params[:type]]).page params[:page]
    else
      @logs = Log.all.order(created_at: :desc).page params[:page]
    end
  end
end
