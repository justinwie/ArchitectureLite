require_relative './lib/associatable'
require_relative './lib/sql_object'

class Character < SQLObject
  self.finalize!
  belongs_to :show
end

class Show < SQLObject
  self.finalize!
  has_many :characters
end
