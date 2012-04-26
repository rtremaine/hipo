class Company < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of   :name

  has_many :users
  has_many :record_sets, :through => :users
  has_many :shares, :class_name => Share,
    :finder_sql => proc{"select * from shares join users on users.id = shares.sender_id where users.company_id = #{id}"}

  def patient_shares(patient_id)
    Share.find(:all,
              :joins => ["JOIN users ON users.id = shares.sender_id", "JOIN record_sets ON record_sets.id = shares.record_set_id"],
              :select => "shares.*, users.*",
              :conditions => {:users => {:company_id => 1}, :record_sets => {:patient_id => patient_id}})
  end
end
