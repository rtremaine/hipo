desc 'Import tech costs'

namespace :bfi do
  task :import_costs => :environment do
    Techcost.import
  end
end
