require "test_helper"

class TaskTest < ActiveSupport::TestCase
   def setup
      @user = User.create(name: 'Sam Smith', email: 'sam@example.com', password: 'welcome', password_confirmation: 'welcome')
      Task.delete_all

      @task = Task.new(title: 'This is a test task', user: @user)
   end

  def test_instance_of_task
    task = Task.new
    assert_instance_of Task, task
  end

  def test_not_instance_of_user
    task = Task.new
    assert_not_instance_of User, task
  end

  def test_value_of_task_assigned
    assert_equal "This is a test task", @task.title
  end

  def test_value_created_at
    assert_nil @task.created_at

    @task.save!
    assert_not_nil @task.created_at
  end

  def test_error_raised
    assert_raises ActiveRecord::RecordNotFound do
      Task.find(SecureRandom.uuid)
    end
  end

  def test_count_of_number_of_tasks
    assert_difference "Task.count" do
      Task.create!(title: 'Creating a task through test', user: @user)
    end
  end
  
  def test_task_should_not_be_valid_without_title
    @task.title = ""
    assert @task.invalid?
  end
end
