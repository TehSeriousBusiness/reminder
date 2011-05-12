# email is used as the name of the validator
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    emailArray = value.split(";")
    emailArray.each do |email|
      unless(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.match(email))
        record.errors[attribute] << "destination " + email + " is wrong"
      end
  end
end