require 'sinatra'
require "sinatra/activerecord"

set :database, "sqlite3:///gardening_task_app.db"


get "/error" do   
	erb :error 
end

get "Error" do 
	erb :error 
end

get "/" do
	@to_dos = GardeningTask.all #@to_dos is an instance variable(array)
	erb :main
end

post "/to_dos" do
	 @new_garden_task = GardeningTask.new #(params[:gardening_task])
	 if @new_garden_task.accept_task("#{params[:description]}")
	 		@new_garden_task.save
			redirect "/"
		else
			erb :error
		end
end

put "/to_dos/:id" do
	@to_dos = GardeningTask.find(params[:id])
		if @to_dos.find_attributes(parama[:id])
			erb :"to_dos/#{:id}"
		else
			erb :error_mistake
		end
end

put "/to_dos/:id/edit" do
	@to_dos = GardeningTask.find(params[:id])
	if @to_dos.find_attributes(parama[:id])
			erb :"to_dos/#{:id}/edit"
		else
			erb :error_mistake
		end
end
get "/choose" do
	erb :choose
end

delete "/to_dos/:id/delete" do
	@to_dos = GardeningTask.find(params[:id])
	
	erb :delete
end

class	GardeningTask < ActiveRecord::Base
	# @@tasks = ["Hedge the Bushes", "Trim the Poplar"]
	# @@common_garden_tasks = ["prune", "cut", "hedge", "trim", "mow", "plant", "cultivate", "till"]
	
	# def initialize (commenting out due to NoMethodError - undefined method `delete' for nil:NilClass:...this was suggested by someone on SOF)
		
	# end

	# def self.tasks (no longer need an array)
	# 	return @@tasks

	# end


	def self.accept_task(text)
		 if evaluate_task(text) == true

				return true
			else
				return true # changed from false to test
			end	
	end

	def self.evaluate_task(text)
		task_to_split = text.downcase
		split_task = task_to_split.split(" ")
		unmatched_tasks = (["prune", "cut", "hedge", "trim", "mow", "plant", "cultivate", "till"] - split_task)
		if unmatched_tasks.length < ["prune", "cut", "hedge", "trim", "mow", "plant", "cultivate", "till"].length
			return true
		else
			return false
		end	
	end
end

