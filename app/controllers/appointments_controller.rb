require_relative '../views/appointments_view'

class AppointmentsController
  def initialize(appointment_repository, doctor_repository, patient_repository)
    @appointment_repository = appointment_repository
    @doctor_repository = doctor_repository
    @patient_repository = patient_repository
    @view = AppointmentsView.new
    @doctors_view = DoctorsView.new
    @patients_view = PatientsView.new
  end

  def create
    @doctors_view.list(@doctor_repository.all)
    doctor_id = @view.ask_doctor_id
    doctor = @doctor_repository.find(doctor_id)

    @patients_view.list(@patient_repository.all)
    patient_id = @view.ask_patient_id
    patient = @patient_repository.find(patient_id)

    date = @view.ask_date

    appointment = Appointment.new(date: date, doctor: doctor, patient: patient)

    @appointment_repository.add(appointment)
  end

  def list
    appointments = @appointment_repository.all
    @view.list(appointments)
  end

end