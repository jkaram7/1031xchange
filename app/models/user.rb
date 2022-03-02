# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  company_name    :string
#  email           :string
#  name            :string
#  password_digest :string
#  phone_number    :string
#  role            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  validates(:role, { :presence => true })
  validates(:phone_number, { :presence => true })
  validates(:name, { :presence => true })
  validates(:company_name, { :presence => true })

  has_many(:acquisition_criteria, { :class_name => "AcquisitionCriterium", :foreign_key => "id_user", :dependent => :destroy })
  has_many(:clicks, { :class_name => "View", :foreign_key => "id_viewer", :dependent => :destroy })
  
end
