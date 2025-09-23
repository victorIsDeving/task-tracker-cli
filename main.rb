require "./functions.rb"

json_path = "./tasks.json"

case ARGV[0]
when "add"
    new_id = add_task(ARGV[1], json_path)
    puts "Task added successfully (ID: #{new_id})"
when "update"
    message = update_task_description(ARGV[1], ARGV[2], json_path)
    puts message
when "delete"
    message = delete_task(ARGV[1], json_path)
    puts message
when "mark-in-progress"
    message = update_task_status(ARGV[1], ARGV[0], json_path)
    puts message
when "mark-done"
    message = update_task_status(ARGV[1], ARGV[0], json_path)
    puts message
when "mark-to-do"
    message = update_task_status(ARGV[1], ARGV[0], json_path)
    puts message
when "list"
    list_task(ARGV[1], json_path)
else
    instructions()
end
