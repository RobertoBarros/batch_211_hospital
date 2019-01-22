require_relative '../models/patient'

class PatientRepository
  def initialize(csv_file, room_repository)
    @csv_file = csv_file
    @patients = []
    @room_repository = room_repository
    load_csv
  end

  def add(patient)
    patient.id = @next_id
    @patients << patient
    save_csv
    @next_id += 1
  end

  def all
    @patients
  end

  def find(id)
    @patients.select { |patient| patient.id == id }.first
  end

  def load_csv
    CSV.foreach(@csv_file) do |row|
      patient = Patient.new(id: row[0].to_i, name: row[1], age: row[2].to_i)
      @patients << patient

      room_id = row[3].to_i
      room = @room_repository.find(room_id)
      room.add_patient(patient)

    end
    @next_id = @patients.empty? ? 1 : @patients.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |file|
      @patients.each do |patient|
        file << [patient.id, patient.name, patient.age, patient.room.id]
      end
    end
  end

end