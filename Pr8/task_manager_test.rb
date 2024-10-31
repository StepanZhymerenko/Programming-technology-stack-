require 'minitest/autorun'
require_relative 'task_manager'
require 'json'

class TaskManagerTest < Minitest::Test
  def setup
    @manager = TaskManager.new
    @manager.tasks.clear # Очищаємо задачі перед кожним тестом
  end

  def test_add_task
    @manager.add_task(1, "Test Task", "2024-12-31")
    assert_equal 1, @manager.tasks.size
    assert_equal "Test Task", @manager.tasks.first[:title]
    assert_equal Date.new(2024, 12, 31), @manager.tasks.first[:deadline]
  end

  def test_delete_task
    @manager.add_task(1, "Task to delete", "2024-12-31")
    task_id = @manager.tasks.first[:id]
    @manager.delete_task(task_id)
    assert_empty @manager.tasks
  end

  def test_edit_task
    @manager.add_task(1, "Initial Task", "2024-12-31")
    task_id = @manager.tasks.first[:id]
    @manager.edit_task(task_id, title: "Updated Task", completed: true)
    assert_equal "Updated Task", @manager.tasks.first[:title]
    assert @manager.tasks.first[:completed]
  end

  def test_list_tasks_by_status
    @manager.add_task(1, "Task 1", "2024-12-31")
    @manager.add_task(2, "Task 2", "2024-11-01")
    @manager.edit_task(1, completed: true)

    output = capture_io do
      @manager.list_tasks(status: true)
    end.first

    assert_match(/Task 1/, output)
    refute_match(/Task 2/, output)
  end

  def test_list_tasks_by_due_date
    @manager.add_task(1, "Task 1", "2024-10-30")
    @manager.add_task(2, "Task 2", "2024-11-02")

    output = capture_io do
      @manager.list_tasks(due_date: "2024-10-31")
    end.first

    assert_match(/Task 1/, output)
    refute_match(/Task 2/, output)
  end

  def test_add_duplicate_task_id
    @manager.add_task(1, "First Task", "2024-12-31")
    output = capture_io do
      @manager.add_task(1, "Duplicate Task", "2024-11-30")
    end.first

    assert_equal 1, @manager.tasks.size
    assert_match(/Task with ID 1 already exists/, output)
  end

  private

  def capture_io
    begin
      out, err = StringIO.new, StringIO.new
      $stdout, $stderr = out, err
      yield
      [out.string, err.string]
    ensure
      $stdout = STDOUT
      $stderr = STDERR
    end
  end
end
