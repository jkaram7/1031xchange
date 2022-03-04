# == Schema Information
#
# Table name: messages
#
#  id             :integer          not null, primary key
#  content        :text
#  read           :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  acquisition_id :integer
#  recipient_id   :integer
#  sender_id      :integer
#
class Message < ApplicationRecord

  belongs_to(:sender, { :required => true, :class_name => "User", :foreign_key => "sender_id" })
  belongs_to(:recipient, { :required => true, :class_name => "User", :foreign_key => "recipient_id" })
  belongs_to(:acquisition, { :required => true, :class_name => "AcquisitionCriterium", :foreign_key => "acquisition_id" })
  
end
