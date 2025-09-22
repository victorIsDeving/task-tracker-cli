require "./functions.rb"

json_path = "./tasks.json"

case ARGV[0]
when "add"
    new_id = add_task(ARGV[1], json_path)
    puts "Task added successfully (ID: #{new_id})"
when "update"
    update_task_description(ARGV[1], ARGV[2], json_path)
    puts "Updated task ID: #{ARGV[1]} name to \"#{ARGV[2]}\""
when "delete"
    delete_task(ARGV[1], json_path)
    puts "Deleted task ID: #{ARGV[1]}"
when "mark-in-progress"
    update_task_status(ARGV[1], ARGV[0], json_path)
    puts "Task ID: #{ARGV[1]} marked as IN-PROGRESS"
when "mark-done"
    update_task_status(ARGV[1], ARGV[0], json_path)
    puts "Task ID: #{ARGV[1]} marked as DONE"
when "list"
    list_task(ARGV[1], json_path)
else
    instructions()
end
