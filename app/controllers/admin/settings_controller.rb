class Admin::SettingsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  # GET /settings
  def index
    if Setting.first.present?
      redirect_to edit_admin_setting_path(Setting.first)
    else
      redirect_to new_admin_setting_path
    end
  end

  # GET /settings/1
  def show
  end

  # GET /settings/new
  def new
    @setting = Setting.new
  end

  # GET /settings/1/edit
  def edit
  end

  # POST /settings
  def create
    @setting = Setting.new(setting_params)

    if @setting.save
      redirect_to edit_admin_setting_path(@setting), notice: 'Setting was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /settings/1
  def update
    if @setting.update(setting_params)
      redirect_to edit_admin_setting_path(@setting), notice: 'Setting was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /settings/1
  def destroy
    @setting.destroy
    redirect_to settings_url, notice: 'Setting was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def setting_params
      params.require(:setting).permit(:app_name, :app_api_key)
    end
end
