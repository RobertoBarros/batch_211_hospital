require 'date'
require_relative '../models/appointment'

class AppointmentRepository

  def initialize(csv_file, doctor_repository, patient_repository)
    @csv_file = csv_file
    @doctor_repository = doctor_repository
    @patient_repository = patient_repository
    @appointments = []
    load_csv
  end

  def add(appointment)
    appointment.id = @next_id
    @appointments << appointment
    save_csv
    @next_id += 1
  end

  def all
    return @appointments
  end

  def load_csv
    CSV.foreach(@csv_file) do |row|
      appointment = Appointment.new(id: row[0].to_i, date: Date.parse(row[1]))

      doctor_id = row[2].to_i
      doctor = @doctor_repository.find(doctor_id)
      appointment.doctor = doctor

      patient_id = row[3].to_i
      patient = @patient_repository.find(patient_id)
      appointment.patient = patient

      @appointments << appointment
    end
    @next_id = @appointments.empty? ? 1 : @appointments.last.id + 1

  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |file|
      @appointments.each do |appointment|
        file << [appointment.id, appointment.date.strftime('%Y-%m-%d'), appointment.doctor.id, appointment.patient.id]
      end
    end
  end
end