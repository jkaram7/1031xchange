# == Schema Information
#
# Table name: acquisition_criteria
#
#  id                :integer          not null, primary key
#  active            :boolean
#  cap_rate_max      :float
#  cap_rate_min      :float
#  id_user           :integer
#  location          :string
#  notes             :text
#  occupancy         :float
#  period_end_date   :datetime
#  preferred_tenant  :string
#  priority          :integer
#  product_type      :string
#  property_sub_type :string
#  return_profile    :string
#  sq_feet           :float
#  trade_size        :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class AcquisitionCriterium < ApplicationRecord

  validates(:trade_size, { :presence => true })
  validates(:product_type, { :presence => true })
  validates(:location, { :presence => true })

  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "id_user" })
  has_many(:views, { :class_name => "View", :foreign_key => "id_acquisition", :dependent => :destroy })
  
end
