RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  # config.include ControllerHelpers, :type => :controller
  # config.extend ControllerMacros, :type => :controller
end
