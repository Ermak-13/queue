class Task
	attr_accessor :finish_time, :description

	def initialize(options = {})
		@finish_time, @description = options[:finish_time], options[:description]
	end

	def valid?
		valid_finish_time? && valid_description?
	end

	def invalid?
		!valid?
	end

	private
		def valid_finish_time?
			@finish_time && @finish_time.is_a?(Time)
		end

		def valid_description?
			@description && @description.is_a?(String) && !@description.empty?
		end
end