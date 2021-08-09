class PatientsController < ApplicationController
  before_action :check_user
  load_and_authorize_resource

  # GET /patients
  def index
    @patients = Patient.all
  end

  # GET /patients/1
  def show
  end

  # GET /patients/new
  def new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  def create

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: "Patient was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  def update
    if patient_params[:password].blank?
      patient_params.delete(:password)
      patient_params.delete(:password_confirmation)
    end
  
    successfully_updated = if needs_password?(@patient, patient_params)
                             @patient.update(patient_params)
                           else
                             @patient.update_without_password(patient_params)
                           end
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: "Patient was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: "Patient was successfully destroyed." }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:name, :surname, :medical_history, :DOB, :city)
    end

    def needs_password?(_patient, params)
      params[:password].present?
    end

    def check_user
      if doctor_signed_in?
        :authenticate_doctor!
      elsif patient_signed_in?
        :authenticate_patient!
      end
    end
end
