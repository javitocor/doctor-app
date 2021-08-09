class DoctorsController < ApplicationController
  before_action :authenticate_doctor!, except: [:index, :show]
  load_and_authorize_resource

  # GET /doctors
  def index
    @doctors = Doctor.all
  end

  # GET /doctors/1
  def show
  end

  # GET /doctors/new
  def new
  end

  # GET /doctors/1/edit
  def edit
  end

  # POST /doctors
  def create

    respond_to do |format|
      if @doctor.save
        format.html { redirect_to @doctor, notice: "Doctor was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doctors/1
  def update
    if doctor_params[:password].blank?
      doctor_params.delete(:password)
      doctor_params.delete(:password_confirmation)
    end
  
    successfully_updated = if needs_password?(@doctor, doctor_params)
                             @doctor.update(doctor_params)
                           else
                             @doctor.update_without_password(doctor_params)
                           end
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.html { redirect_to @doctor, notice: "Doctor was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1
  def destroy
    @doctor.destroy
    respond_to do |format|
      format.html { redirect_to doctors_url, notice: "Doctor was successfully destroyed." }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def doctor_params
      params.require(:doctor).permit(:name, :DOB, :city, :resume, :graduated)
    end

    def needs_password?(_doctor, params)
      params[:password].present?
    end
end
