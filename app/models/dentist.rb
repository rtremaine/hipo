class Dentist < ActiveRecord::Base
  require 'csv'
  has_many    :patients

  def name
    self.last + ', ' + self.first + ' ' + self.title
  end

  def self.fake_ssn
    ssn = ''
    3.times do
      ssn = ssn + rand(1..9).to_s
    end
    ssn = ssn + '-'

    2.times do
      ssn = ssn + rand(1..9).to_s
    end
    ssn = ssn + '-'

    4.times do
      ssn = ssn + rand(1..9).to_s
    end
    ssn
  end

  def self.make_pretend_people
    self.delete_all
    Patient.delete_all

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
        p.last = name[:last]
        p.ssn = Dentist.fake_ssn
        p.save
      end
      puts counter
      counter = counter + 1
    end

  end

  def self.assign_patients_to_dentists
    ps = Patient.all
    ds = Dentist.all
    ps.each do |p|
      unless rand(0..3) == 1
        p.dentist_id = ds[rand(1..ds.size)].id
        p.save
      end
    end
  end
end
