require 'rails_validation/active_record/validations/presence'
require 'rails_validation/active_model/validations/presence'
require 'rails_validation/active_record/persistence'
require 'rails_validation/active_record/validations'
require 'rails_validation/active_model/validator'
require 'rails_validation/active_model/validations'

class Idea < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  mount_uploader :picture, PictureUploader
end
