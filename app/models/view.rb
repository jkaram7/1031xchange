# == Schema Information
#
# Table name: views
#
#  id             :integer          not null, primary key
#  clicked        :boolean
#  id_acquisition :integer
#  id_viewer      :integer
#  potential_lead :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class View < ApplicationRecord

  belongs_to(:clicker, { :required => true, :class_name => "User", :foreign_key => "id_viewer" })
  belongs_to(:view, { :required => true, :class_name => "AcquisitionCriterium", :foreign_key => "id_acquisition" })
  
end
