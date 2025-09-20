require "json"
require "time"

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
        "description"=> ARGV[1],
        "status"=> "to-do",
        "created_at"=> Time.now.utc.iso8601,
        "updated_at"=> Time.now.utc.iso8601
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
    total_tasks = arr["tasks"].length
    i = 0
    while ( i < total_tasks )
        if ( arr["tasks"][i]["task_id"] == id )
            arr["tasks"][i]["description"] = new_task_name
            arr["tasks"][i]["updated_at"] = Time.now.utc.iso8601
            break
        end
        i += 1
    end
    File.open(json_path, "w") do |f|
        f.write(JSON.pretty_generate(arr))
    end
    puts "Updated task ID: #{id} name to \"#{new_task_name}\""
end

if ( ARGV[0] == "delete" )
    id = ARGV[1].to_i
    arr = JSON.parse(File.read(json_path))
    total_tasks = arr["tasks"].length
    i = 0
    while ( i < total_tasks )
        if ( arr["tasks"][i]["task_id"] == id )
            arr["tasks"].delete(arr["tasks"][i])
            break
        end

        i += 1
    end

    File.open(json_path, "w") do |f|
        f.write(JSON.pretty_generate(arr))
    end

    puts "Deleted task ID: #{id}"
end

if ( ARGV[0] == "mark-in-progress")
    id = ARGV[1].to_i
    arr = JSON.parse(File.read(json_path))
    total_tasks = arr["tasks"].length
    i = 0
    while ( i < total_tasks )
        if ( arr["tasks"][i]["task_id"] == id )
            arr["tasks"][i]["status"] = "in-progress"
        end

        i += 1
    end

    File.open(json_path, "w") do |f|
        f.write(JSON.pretty_generate(arr))
    end

    puts "Task ID: #{id} marked as IN-PROGRESS"
end

if ( ARGV[0] == "mark-done")
    id = ARGV[1].to_i
    arr = JSON.parse(File.read(json_path))
    total_tasks = arr["tasks"].length
    i = 0
    while ( i < total_tasks )
        if ( arr["tasks"][i]["task_id"] == id )
            arr["tasks"][i]["status"] = "done"
        end

        i += 1
    end

    File.open(json_path, "w") do |f|
        f.write(JSON.pretty_generate(arr))
    end

    puts "Task ID: #{id} marked as DONE"
end

if ( ARGV[0] == "list")
    arr = JSON.parse(File.read(json_path))
    total_tasks = arr["tasks"].length
    if ( ARGV[1].class == NilClass )
        i = 0
        while ( i < total_tasks )
            puts arr["tasks"][i]

            i += 1
        end
    else
        if ( ARGV[1] == "done" )
            i = 0
            while ( i < total_tasks )
                if ( arr["tasks"][i]["status"] == "done" )
                    puts arr["tasks"][i]
                end

                i += 1
            end
        elsif ( ARGV[1] == "in-progress" )
            i = 0
            while ( i < total_tasks )
                if ( arr["tasks"][i]["status"] == "in-progress" )
                    puts arr["tasks"][i]
                end

                i += 1
            end
        elsif ( ARGV[1] == "to-do")
            i = 0
            while ( i < total_tasks )
                if ( arr["tasks"][i]["status"] == "to-do" )
                    puts arr["tasks"][i]
                end

                i += 1
            end
        end
    end
    
end
