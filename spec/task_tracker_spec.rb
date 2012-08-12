require 'spec_helper'

describe 'TaskTracker' do
	before :each do
		@task = Task.new :finish_time => Time.now + 3600, :description => 'some task'
		@queue = TaskTracker.new @task
	end

	describe 'Push Task' do 
		it 'should raise error' do
			task = Task.new
			lambda { @queue.push(task) }.should raise_error
		end
	end

	describe 'Pop Task' do
		it 'should return nil' do
			queue = TaskTracker.new
			queue.pop.should eq(nil)
		end
		
		it 'should return first task' do
			task = Task.new :finish_time => Time.now + 1800, :description => 'some task'
			@queue.push task
			@queue.pop.should eq(@task)
		end

		it 'should return expired task' do
			task = Task.new :finish_time => Time.now - 3600, :description => 'some task'
			@queue.push task
			@queue.pop.should eq(task)
		end
	end

	describe 'Get Task by Finish Time' do
		it 'should return nil' do
			@queue.get_task(Time.now).should eq(nil)
		end

		it 'should return task' do
			@queue.get_task(@task.finish_time).should eq(@task)
		end

		it 'should return expired task' do
			task = Task.new :finish_time => Time.now - 3600, :description => 'some task'
			@queue.push task
			@queue.get_task(Time.now).should eq(task)
		end
	end
end