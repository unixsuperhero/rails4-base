require 'csv'

CSV.foreach(File.join(Rails.root, 'doc/appt_data.csv'), headers: true) do |row|
  hash = row.to_hash.with_indifferent_access
  hash.merge!(start_time: Time.strptime(hash[:start_time], '%m/%d/%y %H:%M'),
                end_time: Time.strptime(hash[  :end_time], '%m/%d/%y %H:%M'))
  appt = Appointment.create(hash)
end

