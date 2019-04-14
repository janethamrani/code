require 'test_helper'

class AdminTest < ActiveSupport::TestCase
 devise :database_authenticatable, :trackable, :timeoutable, :lockable
end
