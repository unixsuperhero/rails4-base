class AppointmentsController < ApplicationController
  expose(:start_time) { params[:start_time] || params[:appointment][:start_time] }
  expose(:end_time) { params[:end_time] || params[:appointment][:end_time] }

  expose(:attributes) {
    params.require(:appointment).permit(*permitted_attributes)
  }

  expose(:appointment) { Appointment.find_by(id: params[:id]) }
  expose(:new_appointment) { Appointment.new(attributes) }
  expose(:permitted_attributes) {
    [
      :start_time,
      :end_time,
      :first_name,
      :last_name
    ]
  }

  before_filter :ensure_param_namespace
  before_filter :ensure_appointment_exists, only: [:update, :destroy]
  before_filter :appointment_is_in_the_future, only: [:create, :update]

  def index
    appointments = times_exist? ?
      Appointment.where("start_time >= ? and end_time <= ?", start_time, end_time).all :
      Appointment.all
    render json: appointments
  end

  def show
    render json: appointment
  end

  def create
    status, json = 200, { status: :success, message: 'Appointment created successfully' }

    status, json = 400, {
      status: :error,
      message: new_appointment.errors.full_messages
    } unless new_appointment.save

    render json: json, status: status
  end

  def update
    status, json = 200, { status: :success, message: 'Appointment updated successfully' }

    status, json = 400, {
      status: :error,
      message: appointment.errors.full_messages
    } unless appointment.update_attributes(attributes)

    render json: json, status: status
  end

  def destroy
    status, json = 200, { status: :success, message: 'Appointment deleted successfully' }

    status, json = 400, {
      status: :error,
      message: 'Unable to cancel appointment'
    } unless appointment.destroy

    render json: json, status: status
  end

private

  def times_exist?
    start_time.present? && end_time.present?
  end

  def appointment_is_in_the_future
    return true if times_exist? && Time.parse(start_time) > Time.now && Time.parse(end_time) > Time.now
    render status: 400, json: { status: :error, message: 'Appointment times must be in the future' }
    false
  end

  def ensure_param_namespace
    params.merge!(appointment: params.permit(*permitted_attributes).presence || {})
  end

  def ensure_appointment_exists
    return true if appointment.present?
    render status: 400, json: { status: :error, message: 'Appointment not found' }
    false
  end

end
