class SkillAssignment < ActiveRecord::Base
  belongs_to :skill
  belongs_to :owner, polymorphic: true
end