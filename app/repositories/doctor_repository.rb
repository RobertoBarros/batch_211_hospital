require_relative '../models/doctor'

class DoctorRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @doctors = []
    load_csv
  end

  def add(doctor)
    doctor.id = @next_id
    @doctors << doctor
    save_csv
    @next_id += 1
  end

  def all
    return @doctors
  end

  def find(id)
    @doctors.select { |doctor| doctor.id == id }.first
  end

  def load_csv
    CSV.foreach(@csv_file) do |row|
      doctor = Doctor.new(id: row[0].to_i, name: row[1])
      @doctors << doctor
    end
    @next_id = @doctors.empty? ? 1 : @doctors.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |file|
      @doctors.each do |doctor|
        file << [doctor.id, doctor.name]
      end
    end
  end


end