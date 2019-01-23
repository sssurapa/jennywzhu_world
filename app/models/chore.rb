class Chore < ApplicationRecord
    belongs_to :child 
    belongs_to :task 
    
    validates_timeliness_of :due_on
    scope :alphabetical, -> { order(:name) }
    scope :chronological, -> { order(:due_on, :completed) }
    scope :pending, -> { where(:completed => false) }  
    scope :done, -> { where(:completed => true) } 
    scope :upcoming, lambda { where("due_on >= ?", Date.today) } 
    scope :past, lambda { where("due_on < ?", Date.current) } 
    scope :by_task, -> { joins(:task).order("tasks.name") }
    
    def status 
        if completed == true 
            return "Completed" 
        elsif completed == false 
            return "Pending" 
        end 
    end 
    
end
