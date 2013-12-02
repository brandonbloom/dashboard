class ScriptLevel < ActiveRecord::Base
  belongs_to :level
  belongs_to :script

  NEXT = 'next'

  # this is
  attr_accessor :user_level

  def next_level
    self.script.get_script_level_by_chapter(self.chapter + 1)
  end

  def previous_level
    self.script.get_script_level_by_chapter(self.chapter - 1)
  end
end
