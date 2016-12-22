class DevicesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  layout "startup"

  # GET /users/:user_id/devices
  # GET /users/:user_id/devices.json
  def index
    @devices = @user.devices
  end

  def assign_ip_address
    case request.method
      when "GET"
        @device = Device.find(params[:id])
      when "POST"
        #save form params to db
        respond_to do |format|
          @device = Device.find_by_name(params[:name])
          if @device
            @ip_add = @device.ip_addresses.new(:ip_value => params[:ip_address])
            if @ip_add.save
              format.html { redirect_to user_device_path(@user, @device),
                            notice: "Ip Address is successfully assigned to the device #{@device.name}." }
            else
              format.html { render :assign_ip_address, :locals => {:device_name => @device.name} }
            end
          end
        end

    end
  end

  # GET /users/:user_id/devices/:1
  # GET /users/:user_id/devices/1.json
  def show
  end

  # GET /users/:user_id/devices/new
  def new
    @device = Device.new
  end

  # GET /users/:user_id/devices/1
  def edit
  end

  # POST /users/:user_id/devices
  # POST /users/:user_id/devices.json
  def create
    @device = @user.devices.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to user_devices_path(@user), notice: 'Device was successfully added.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/:user_id/devices/1
  # PATCH/PUT /users/:user_id/devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params) &&
        format.html { redirect_to user_devices_path(@user), notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:user_id/devices/1
  # DELETE /users/:user_id/devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to user_devices_url, notice: 'Device was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

  def set_user
    @user = User.find(params[:user_id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def device_params
    params.require(:device).permit(:name)
  end

end