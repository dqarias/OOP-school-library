require_relative('person')

class Student < Person
  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission:)
    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end

student1 = Student.new(16, 'Segundo', 'Dino' )
p student1
print student1.can_use_services?
