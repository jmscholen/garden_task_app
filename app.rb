require 'sinatra'

get "/error" do   
	erb :error 
end

get "Error" do 
	erb :error 
end

get "/" do
	@to_dos = Gardening.tasks #@to_dos is an instance variable(array)
	erb :main
end

post "/to_dos" do
	text = params[:description]
	 	if Gardening.accept_task(text)
	 		# @to_dos = Gardening.tasks
	 		# erb :main #puts a nilclass error for the each method
			redirect "/"
		else
			erb :error
		end
end

get "/choose" do
	erb :choose
end






class	Gardening 
	@@tasks = ["Hedge the Bushes", "Trim the Poplar"]
	@@common_garden_tasks = ["prune", "cut", "hedge", "trim", "mow", "plant", "cultivate", "till"]
	
	def initialize
		
	end

	def self.tasks
		return @@tasks

	end


	def self.accept_task(task)
		 if evaluate_task(task) == true
		 		@@tasks.push(task)
				return true
			else
				return false
			end	
	end

	def self.evaluate_task(task)
		task_to_split = task.downcase
		split_task = task_to_split.split(" ")
		unmatched_tasks = (@@common_garden_tasks - split_task)
		if unmatched_tasks.length < @@common_garden_tasks.length
			
			return true
		else
			return false
		end	
	end


end

