require "json"

if ( ARGV.length == 0 )
    puts "Usage: ruby main.rb COMMAND ({ID} | {TASK_NAME} | {STATUS})"
end

json_path = "./tasks.json"

file = File.read(json_path)
parsed_file = JSON.parse(file)
last_id = parsed_file["last_id"]

if ( ARGV[0] == "add" )
    new_id = last_id + 1
    new_entry_hash = {
        "task_id"=> new_id,
        "task_name"=> ARGV[1],
        "task_status"=> "todo"
    }
    arr = JSON.parse(File.read(json_path))
    arr["tasks"] << new_entry_hash
    arr["last_id"] = new_id

    File.open(json_path, "w") do |f|
        f.write(JSON.pretty_generate(arr))
    end
    puts "Task added successfully (ID: #{new_id})"
end

if ( ARGV[0] == "update" )
    id = ARGV[1]
    id = id.to_i
    new_task_name = ARGV[2]
    arr = JSON.parse(File.read(json_path))
    puts "#{id.class}"
    total_tasks = arr["tasks"].length
    i = 0
    while ( i < total_tasks )
        if ( arr["tasks"][i]["task_id"] == id )
            arr["tasks"][i]["task_name"] = new_task_name
            break
        end
        i = i + 1
    end
    File.open(json_path, "w") do |f|
        f.write(JSON.pretty_generate(arr))
    end
    puts "Updated task ID: #{id} name to \"#{new_task_name}\""
end

