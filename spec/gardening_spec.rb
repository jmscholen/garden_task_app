require 'rspec'
require './app.rb'




describe Gardening do
	let(:my_tasks) {Gardening.new}
	
	it 'should have a some task to complete' do
		my_tasks.tasks.should_not be_empty
	end

	it 'should accept a task' do
		task = ("Prune the trees.")
		my_tasks.accept_task(task)
		my_tasks.tasks[-1].should eq("Prune the trees.")
	end

	it 'should_not accept a bogus task' do
		task = ("File my papers.")
		my_tasks.accept_task(task)
		my_tasks.tasks[-1].should_not eq("File my papers.")
	end

end
