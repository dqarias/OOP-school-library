require_relative('nameable')
require_relative('capitalize_decorator')
require_relative('trimmer_decorator')

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1...10_000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  private

  def of_age?
    return true if @age >= 18
    return false if @age < 18
  end

  public

  def can_use_services?
    if of_age? || @parent_permission
      true
    else
      false
    end
  end

  def correct_name
    @name
  end
end

person1 = Person.new(16, 'Ronald', parent_permission: false)
p person1
puts person1.can_use_services?

person = Person.new(22, 'maximilianus')
puts person.correct_name
puts capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
puts capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name
