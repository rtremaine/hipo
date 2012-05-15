# this fixes a bug betweeen Kaminari (used by rails_admin) and will_paginate (used by Ted)
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end
