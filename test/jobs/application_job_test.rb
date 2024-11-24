require "test_helper"

class ApplicationJobTest < ActiveJob::TestCase
  test "ApplicationJob inherits from ActiveJob::Base" do
    assert ApplicationJob < ActiveJob::Base, "Check class ApplicationJob inherit from ActiveJob::Base"
  end
end
