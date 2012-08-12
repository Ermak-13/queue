require 'rubygems'
require 'bundler/setup'
require 'thread'

class TaskTracker
	def initialize(*tasks)
		@tasks = []
		tasks.each { |task| @tasks.push task }
		@lock = Mutex.new
	end

	def push(task)
		@lock.synchronize {
			raise "Invalid task #{task.object_id}" if task.invalid?
			@tasks.push task
		}
	end

	def pop
		@lock.synchronize {
			expired_task || @tasks.shift
		}
	end

	def get_task(finish_time)
		@lock.synchronize {
			task = @tasks.select { |task| task.finish_time == finish_time }.first
			expired_task || task
		}
	end

	private
		def expired_task
			task = @tasks.select { |task| task.finish_time < Time.now }.
				sort_by { |task| task.finish_time }.first
			@tasks.delete task
		end
end