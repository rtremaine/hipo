# RailsAdmin config file. Generated on May 14, 2012 10:16 PM
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Hippo', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Company, Contact, Dentist, Patient, Plan, Record, RecordSet, Share, SharingMode, Subscription, User]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [Company, Contact, Dentist, Patient, Plan, Record, RecordSet, Share, SharingMode, Subscription, User]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Company do
  #   # Found associations:
  #     configure :users, :has_many_association 
  #     configure :record_sets, :has_many_association 
  #     configure :shares, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Contact do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :company, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :created_by, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :confirmed, :boolean 
  #     configure :company_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Dentist do
  #   # Found associations:
  #     configure :patients, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :first, :string 
  #     configure :last, :string 
  #     configure :middle, :string 
  #     configure :address1, :string 
  #     configure :address2, :string 
  #     configure :user_id, :integer 
  #     configure :email, :string 
  #     configure :city, :string 
  #     configure :state, :string 
  #     configure :zip, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :title, :string 
  #     configure :company_id, :integer 
  #     configure :fax, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Patient do
  #   # Found associations:
  #     configure :company, :belongs_to_association 
  #     configure :record_sets, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :first, :string 
  #     configure :last, :string 
  #     configure :ssn, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :company_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Plan do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :price, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Record do
  #   # Found associations:
  #     configure :patient, :belongs_to_association 
  #     configure :record_set, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :patient_id, :integer         # Hidden 
  #     configure :description, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :record, :carrierwave 
  #     configure :record_set_id, :integer         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model RecordSet do
  #   # Found associations:
  #     configure :patient, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :records, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :patient_id, :integer         # Hidden 
  #     configure :name, :string 
  #     configure :description, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :user_id, :integer         # Hidden 
  #     configure :status, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Share do
  #   # Found associations:
  #     configure :sender, :belongs_to_association 
  #     configure :recipient, :belongs_to_association 
  #     configure :record_set, :belongs_to_association 
  #     configure :recipient_user, :has_one_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :sender_id, :integer         # Hidden 
  #     configure :recipient_id, :integer         # Hidden 
  #     configure :record_set_id, :integer         # Hidden 
  #     configure :received_date, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :emailed_date, :datetime 
  #     configure :comment, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model SharingMode do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :description, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Subscription do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :plan, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :active, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :plan_id, :integer         # Hidden 
  #     configure :current_period_end, :datetime 
  #     configure :current_period_start, :datetime 
  #     configure :status, :string 
  #     configure :trial_end, :datetime 
  #     configure :trial_start, :datetime 
  #     configure :stripe_card_token, :string 
  #     configure :stripe_customer_token, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :company, :belongs_to_association 
  #     configure :sharing_mode, :belongs_to_association 
  #     configure :subscription, :has_one_association 
  #     configure :contacts, :has_many_association 
  #     configure :record_sets, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :company_id, :integer         # Hidden 
  #     configure :stripe_customer_token, :string 
  #     configure :is_admin, :boolean 
  #     configure :name, :string 
  #     configure :sharing_mode_id, :integer         # Hidden 
  #     configure :authentication_token, :string 
  #     configure :company_name, :string 
  #     configure :invited_by_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
