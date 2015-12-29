require 'rails_helper'

RSpec.describe Device, type: :model do
	let(:device_name) { "first_dev" }
	let(:device_address) { "AA:BB:CC:DD:EE:FF" }
	let(:device_user_id) { 1 }
	let(:device) { Device.create(name: device_name, address: device_address, user_id: device_user_id) }

	context "column list - " do
		context "has the cloumn: " do
			it "name" do
				expect{device.name}.not_to raise_error
			end

			it "address" do
				expect{device.address}.not_to raise_error
			end

			it "user_id" do
				expect{device.user_id}.not_to raise_error
			end
		end
	end

	context "handling input - " do
		let(:faulty_names_type)					{ [ 1234,
																				true,
																				["Front Door"]
																			]
																		}
		let(:too_long_name)							{ "You must be Jokingly Long String" }
		let(:too_short_name)						{ "abc" }
		let(:miniumn_name)							{ "Jane" }

		let(:faulty_addresses_type)			{ [ "AABB:CC:DD:EE:FF",
																				"AA:BBCC:DD:EE:FF",
																				"AA:BB:CCDD:EE:FF",
																				"AA:BB:CC:DDEE:FF",
																				"AA:BB:CC:DD:EEFF",
																				"A:B:C:D:E:F",
																				"::::",
																				"",
																				nil,
																				1234,
																				true,
																				["AA:BB:CC:DD:EE:FF"]
																			]
																		}



		context "for 'name' column: " do
			it "validates input type and only accept string" do
				faulty_names_type.each do | faulty_name |
					expect { Device.create(name: faulty_name, address: device_address, user_id: device_user_id) }.to raise_error ArgumentError
				end
				expect { Device.create(name: device_name, address: device_address, user_id: device_user_id) }.not_to raise_error
			end

			it "accepts name not longer than 16 characters" do
				expect { Device.create(name: too_long_name, address: device_address, user_id: device_user_id) }.to raise_error ArgumentError
			end

			it "accepts name not shorter than 4 characters" do
				expect { Device.create(name: too_short_name, address: device_address, user_id: device_user_id) }.to raise_error ArgumentError
			end

			it "accepts name with 4 minimum characters" do
				expect { Device.create(name: miniumn_name, address: device_address, user_id: device_user_id) }.not_to raise_error ArgumentError
			end
		end

	context "for 'address' column: " do
			it "validates input type and only accept string" do
				faulty_addresses_type.each do | faulty_address |
					expect { Device.create(name: device_name, address: faulty_address, user_id: device_user_id) }.to raise_error ArgumentError
				end
				expect { Device.create(name: device_name, address: device_address, user_id: device_user_id) }.not_to raise_error
			end
		end
	end

	context "general output - " do
		it "returns the latest data first" do
			first_device = Device.create(name: "first_dev", address:"AB:DD:CD:EE:FF:DD", user_id: 1)
			second_device = Device.create(name: "second_dev", address:"AB:BB:CD:EE:FF:DD", user_id: 2)
			expect(Device.first).to eq second_device
		end
	end

end
