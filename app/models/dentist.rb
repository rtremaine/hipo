class Dentist < ActiveRecord::Base
require 'csv'

  def self.make_pretend_dentists
    self.delete_all

    towns = Array.new
    names = Array.new
    streets = Array.new
    dentists = Array.new
    patients = Array.new

    CSV.foreach("./misc/data/towns.csv") do |row|
      towns << row[0]
    end

    CSV.foreach("./misc/data/randomNames.csv") do |row|
      names << { :first => row[0], 
        :last => row[1], 
        :middle => row[2] }
    end

    #TODO get the street names going
    streets << 'Main St'

    #TODO dedupe the names

    counter = 0
    names.each do |name|
      if rand(2) == 0
        d = Dentist.new
        d.first = name[:first]
        d.last = name[:last]
        d.middle = name[:middle] + '.'
        d.city = towns[rand(0..towns.size)]
        d.address1 = rand(0..100).to_i.to_s + ' ' + streets[0]
        d.state = 'Massachusetts'
        d.title = 'D.M.D.'
        d.save
      else
        p = Patient.new
        p.first = name[:first]
      end
      puts counter
      counter = counter + 1
    end

    towns
  end
end
