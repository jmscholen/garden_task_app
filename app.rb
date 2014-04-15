require 'sinatra'

# get '/' do
#   erb :layout
# end

get "/" do
	@new_garden_tasks = Gardening.tasks
	erb :layout => :main
end

get "/error" do
	erb :layout
end


class	Gardening 
	@@tasks =["Trim the hedges", "Plant the flowers"]
	attr_reader :tasks
	def initialize
		
		@new_task = []
		@common_garden_tasks = ["prune", "cut", "hedge", "trim", "mow", "plant", "cultivate", "till"]
	end

	def self.tasks
		@@tasks
	end


	def accept_task(task)
		 if evaluate_task(task) == true
				@@tasks.push(task)
			else
				puts "I do not recognize that as a Gardening task."	
			end	
	end

	def evaluate_task(task)
		task_to_split = task.downcase
		split_task = task_to_split.split(" ")
		unmatched_tasks = (@common_garden_tasks-split_task)
		if unmatched_tasks.length < @common_garden_tasks.length
			return true
		else
			return false
		end	
	end


end

