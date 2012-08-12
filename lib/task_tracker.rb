require 'rubygems'
require 'bundler/setup'

class TaskTracker
	attr_writer :tasks

	def initialize(*tasks)
		@tasks = []
		tasks.each { |task| @tasks.push task }
	end

	def push(task)
		raise "Invalid task #{task.object_id}" if task.invalid?
		@tasks.push task
	end

	def pop
		expired_task || @tasks.shift
	end

	def get_task(finish_time)
		task = @tasks.select { |task| task.finish_time == finish_time }.first
		expired_task || task
	end

	private
		def expired_task
			task = @tasks.select { |task| task.finish_time < Time.now }.
				sort_by { |task| task.finish_time }.first
			@tasks.delete task
		end
end