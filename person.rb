class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1...10_000)
    @name = name
    @age = age
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
end

person1 = Person.new(16, 'Ronald', parent_permission: false)
p person1
puts person1.can_use_services?
