class Device < ActiveRecord::Base
	has_many :users
	default_scope { order('id DESC') }

	def name=(value)
    raise ArgumentError unless value.is_a?(String)
    raise ArgumentError unless value.length >= 4
    raise ArgumentError unless value.length <= 16
    super
	end

def address=(value)
    #^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$
    raise ArgumentError unless value.is_a?(String)
    raise ArgumentError unless /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/ =~ value
    super
  end

end
