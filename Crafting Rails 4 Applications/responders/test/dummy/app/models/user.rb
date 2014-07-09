class User < ActiveRecord::Base

	before_destroy :destroyable?

	def destroyable?
		if name == 'Undestroyable'
			errors.add(:base, 'is understroyable')
			false
		end
	end
end
