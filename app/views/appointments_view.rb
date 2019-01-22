class AppointmentsView

    def ask_doctor_id
      puts "Enter doctor id:"
      gets.chomp.to_i
    end

    def ask_patient_id
      puts "Enter patient id:"
      gets.chomp.to_i
    end

    def ask_date
      puts "Enter date (format: YYYY-MM-DD)"
      Date.parse(gets.chomp)
    end

  def list(appointments)
    system "clear"
    puts ("-" * 15) + 'Appointments List' + ("-" * 15)
    appointments.each do |appointment|
      puts "#{appointment.date.strftime('%Y-%m-%d')} | Doctor: #{appointment.doctor.name} | Patient: #{appointment.patient.name}"
    end
    puts ('-' * 30)
    puts "\n\n"
    puts 'Press enter to continue...'
    gets
  end


end