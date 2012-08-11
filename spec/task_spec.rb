require 'spec_helper'

describe 'Task' do
	before :each do 
		# Time.now + 3600 - next hour
		@task = Task.new :finish_time => (Time.now + 3600), :description => 'some task'
	end

	it 'should be invalid' do
		task = Task.new
		task.should_not be_valid
	end

	it 'should be valid' do 
		@task.should be_valid
	end

	describe 'finish_time' do
		it 'should not be nil' do
			@task.finish_time = nil
			@task.should_not be_valid
		end

		it 'should be time' do
			@task.finish_time = 'not time object'
			@task.should_not be_valid
		end
	end

	describe 'description' do
		it 'should not be nil' do
			@task.description = nil
			@task.should_not be_valid
		end

		it 'should be string' do
			@task.description = 0
			@task.should_not be_valid
		end

		it 'should not be empty string' do
			@task.description = ''
			@task.should_not be_valid
		end
	end

end