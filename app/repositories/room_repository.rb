require_relative '../models/room'

class RoomRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @rooms = []
    load_csv
  end

  def add(room)
    room.id = @next_id
    @rooms << room
    save_csv
    @next_id += 1
  end

  def all
    @rooms
  end

  def find_by_number(number)
    @rooms.select { |room| room.number == number }.first
  end

  def find(id)
    @rooms.select { |room| room.id == id }.first
  end


  def load_csv
    CSV.foreach(@csv_file) do |row|
      room = Room.new(id: row[0].to_i, number: row[1].to_i, capacity: row[2].to_i)
      @rooms << room
    end
    @next_id = @rooms.empty? ? 1 : @rooms.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |file|
      @rooms.each do |room|
        file << [room.id, room.number, room.capacity]
      end
    end
  end

end