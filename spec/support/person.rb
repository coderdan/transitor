require 'active_record'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: 'transitor.db'
class Person < ActiveRecord::Base
  connection.create_table table_name, force: true do |t|
    t.string :name
  end
end

