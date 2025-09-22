require "./functions.rb"

json_path = "./tasks.json"

if ( ARGV.length == 0 )
    puts "Usage: ruby main.rb COMMAND ({ID} | {TASK_NAME} | {STATUS})"
end

if ( ARGV[0] == "add" )
    new_id = add_task(ARGV[1], json_path)
    puts "Task added successfully (ID: #{new_id})"
end

if ( ARGV[0] == "update" )
    update_task_description(ARGV[1], ARGV[2], json_path)
    puts "Updated task ID: #{ARGV[1]} name to \"#{ARGV[2]}\""
end

if ( ARGV[0] == "delete" )
    delete_task(ARGV[1], json_path)
    puts "Deleted task ID: #{ARGV[1]}"
end

if ( ARGV[0] == "mark-in-progress")
    update_task_status(ARGV[1], ARGV[0], json_path)
    puts "Task ID: #{ARGV[1]} marked as IN-PROGRESS"
end

if ( ARGV[0] == "mark-done")
    update_task_status(ARGV[1], ARGV[0], json_path)
    puts "Task ID: #{ARGV[1]} marked as DONE"
end

if ( ARGV[0] == "list")
    list_task(ARGV[1], json_path)
end
