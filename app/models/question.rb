class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, reject_if: proc {|a| a['content'].blank?}, allow_destroy: true

  # 더미 컨텐츠를 파라미터로 받기위한 fake method
  def dummy_content
  end
end
