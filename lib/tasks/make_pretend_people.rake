desc 'Create a slew of pretend dentists and patients'

namespace :hippo do
  task :make_pretend_people => :environment do
    debugger
    Dentist.make_pretend_people
  end
end
