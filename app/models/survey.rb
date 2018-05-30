class Survey < ApplicationRecord
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, reject_if: proc {|a| a['content'].blank?}, :allow_destroy => true
end
