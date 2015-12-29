class User < ActiveRecord::Base
	belongs_to :devices
end
