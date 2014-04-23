require 'sinatra'
require "sinatra/activerecord"

set :database, "sqlite3:///gardening_task_app.db"

########THINGS TO ADD:
######### - CSS CLASSES TO THE SHOW PAGE FOR EDIT AND DELETE
#########
get "/error" do   
	erb :"to_dos/error"
end

get "/Error" do 
	erb :"to_dos/error" 
end
############Read Your List###########
get "/" do
	@to_dos = GardeningTask.all #@to_dos is an instance variable(array)
	erb :"to_dos/show"
end

############Post a new task which is pulled from :new Page
get "/new" do
	erb :"to_dos/new"
end

post "/to_dos" do
	 @new_garden_task = GardeningTask.new(params[:gardening_task])
	 @check_description = @new_garden_task.description
	 if @new_garden_task.accept_task(@check_description)
	 		@new_garden_task.save
			redirect "/"
		else
			erb :"to_dos/error"
		end
end
##############Edit a task which is pulled from :edit Pag
###########
get "/to_dos/:id/edit" do
	@to_dos = GardeningTask.find(params[:id])
	
	erb :"/to_dos/edit"
end

put "/to_dos/:id/edit" do
	@to_dos = GardeningTask.find(params[:id])
	@to_dos.update_attributes(params[:gardening_tasks])
	
	redirect "/"

end


get "/to_dos/:id/delete" do
	@to_dos = GardeningTask.find(params[:id])
	@to_dos.destroy

	redirect "/"
end

class GardeningTask < ActiveRecord::Base
	# @@tasks = ["Hedge the Bushes", "Trim the Poplar"]
	#@@common_garden_tasks = ["prune", "cut", "hedge", "trim", "mow", "plant", "cultivate", "till"]
	
	# def initialize (commenting out due to NoMethodError - undefined method `delete' for nil:NilClass:...this was suggested by someone on SOF)
		
	# end

	# def self.tasks (no longer need an array)
	# 	return @@tasks

	# end


	def accept_task(text)
		 if evaluate_task(text) 
		 	return true
		else
			return false
		end	
	end

	def evaluate_task(text)
		task_to_split = text.downcase
		print (task_to_split + "downcase")
		split_task = task_to_split.split(" ")
		print (split_task)
		unmatched_tasks = (["prune", "cut", "hedge", "trim", "mow", "plant", "cultivate", "till"] - split_task)
		if unmatched_tasks.length < ["prune", "cut", "hedge", "trim", "mow", "plant", "cultivate", "till"].length
			return true
		else
			return false
		end	
	end
end

