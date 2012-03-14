class Share < ActiveRecord::Base
  belongs_to  :recipient, :class_name => 'Contact'
  belongs_to  :record_set

  validates_presence_of :record_set
end
