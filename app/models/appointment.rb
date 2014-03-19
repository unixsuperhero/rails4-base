class Appointment < ActiveRecord::Base
  validate :appointment_time_available

  def appointment_time_available
    conditions = Appointment.where("(TIMESTAMP ?, TIMESTAMP ?) OVERLAPS (start_time, end_time)",
                                                                  start_time, end_time)
    conditions = conditions.where("id != ?", self.id) unless new_record?
    return true if conditions.none?
    errors.add(:base, 'Appointment times conflict with another appointment')
  end
end
