require 'json'
require 'date'

class TaskManager
  attr_accessor :tasks

  FILE_PATH = 'tasks.json'

  def initialize
    @tasks = load_tasks
  end

  def add_task(id, title, deadline)
    # Перевірка на дублікати за ID
    existing_task = @tasks.find { |task| task[:id] == id }
    if existing_task
      puts "Task with ID #{id} already exists. Task not added."
      return
    end

    formatted_deadline = parse_deadline(deadline)
    task = {
      id: id,
      title: title,
      deadline: formatted_deadline,
      completed: false
    }
    @tasks << task
    save_tasks
  end


  def delete_task(id)
    @tasks.reject! { |task| task[:id] == id }
    save_tasks
  end

  def edit_task(id, title: nil, deadline: nil, completed: nil)
    task = @tasks.find { |t| t[:id] == id }
    return unless task

    task[:title] = title if title
    task[:deadline] = parse_deadline(deadline) if deadline
    task[:completed] = completed unless completed.nil?
    save_tasks
  end

  def list_tasks(status: nil, due_date: nil)
    filtered_tasks = @tasks

    # Фільтрація за статусом
    filtered_tasks = filtered_tasks.select { |task| task[:completed] == status } unless status.nil?

    # Фільтрація за дедлайном
    if due_date
      parsed_due_date = parse_deadline(due_date) # Обробка введеної дати
      filtered_tasks = filtered_tasks.select do |task|
        task_deadline = task[:deadline].is_a?(String) ? Date.parse(task[:deadline]) : task[:deadline]
        task_deadline <= parsed_due_date
      end
    end

    # Виведення результату
    if filtered_tasks.empty?
      puts "No tasks found."
    else
      filtered_tasks.each do |task|
        puts "ID: #{task[:id]}, Title: #{task[:title]}, Deadline: #{task[:deadline]}, Completed: #{task[:completed]}"
      end
    end
  end



  private

  def parse_deadline(deadline)
    # Підтримка форматів YYYY-MM-DD та DD.MM.YYYY
    deadline.include?('.') ? Date.strptime(deadline, '%d.%m.%Y') : Date.parse(deadline)
  end

  def save_tasks
    File.write(FILE_PATH, JSON.pretty_generate(@tasks))
  end

  def load_tasks
    File.exist?(FILE_PATH) ? JSON.parse(File.read(FILE_PATH), symbolize_names: true) : []
  end
end

def main
  manager = TaskManager.new

  loop do
    puts "\n1. Add task\n2. Delete task\n3. Edit task\n4. List tasks\n5. Exit"
    print "Choose an option: "
    choice = gets.chomp.to_i

    case choice
    when 1
      print "Enter task ID: "
      id = gets.chomp.to_i
      print "Enter title: "
      title = gets.chomp
      print "Enter deadline (YYYY-MM-DD or DD.MM.YYYY): "
      deadline = gets.chomp
      manager.add_task(id, title, deadline)
      puts "Task added successfully!"

    when 2
      print "Enter task ID to delete: "
      id = gets.chomp.to_i
      manager.delete_task(id)
      puts "Task deleted successfully!"

    when 3
      print "Enter task ID to edit: "
      id = gets.chomp.to_i
      print "Enter new title (leave blank to skip): "
      title = gets.chomp
      print "Enter new deadline (YYYY-MM-DD or DD.MM.YYYY, leave blank to skip): "
      deadline = gets.chomp
      print "Is the task completed? (yes/no, leave blank to skip): "
      completed = gets.chomp
      completed = completed.empty? ? nil : completed == 'yes'
      manager.edit_task(id, title: title.empty? ? nil : title, deadline: deadline.empty? ? nil : deadline, completed: completed)
      puts "Task edited successfully!"

    when 4
      print "Filter by completed status? (yes/no/leave blank): "
      status_input = gets.chomp
      status = status_input.empty? ? nil : status_input == 'yes'
      print "Filter by due date? (YYYY-MM-DD/leave blank): "
      due_date = gets.chomp
      puts "Tasks matching filters:" unless due_date.empty? || status_input.empty?
      manager.list_tasks(status: status, due_date: due_date.empty? ? nil : due_date)

    when 5
      puts "Goodbye!"
      break

    else
      puts "Invalid choice, please try again."
    end
  end
end

main if __FILE__ == $0
