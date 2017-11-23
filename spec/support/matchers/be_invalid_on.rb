RSpec::Matchers.define :be_invalid_on do |attr_name|
  match do |model|
    model.send("#{attr_name}=", @value)
    model.invalid? && model.errors[attr_name].size >= 1
  end

  chain :with do |value|
    @value = value
  end

  failure_message do |model|
    if model.valid?
      "expect #{model.class} to be invalid but it is VALID"
    else
      "expect #{model.class} to have errors on #{attr_name} but EMPTY"
    end
  end
end