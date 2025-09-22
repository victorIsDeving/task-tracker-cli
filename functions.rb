require "json"
require "time"

def add_task(description, json_path)
    arr = JSON.parse(File.read(json_path))
    last_id = arr["last_id"]
    new_id = last_id + 1
    new_entry_hash = {
        "task_id"=> new_id,
        "description"=> description,
        "status"=> "to-do",
        "created_at"=> Time.now.utc.iso8601,
        "updated_at"=> Time.now.utc.iso8601
    }
    arr["tasks"] << new_entry_hash
    arr["last_id"] = new_id

    File.open(json_path, "w") do |f|
        f.write(JSON.pretty_generate(arr))
    end

    return new_id
end

def update_task_description(id, new_description, json_path)
    id = id.to_i
    arr = JSON.parse(File.read(json_path))
    total_tasks = arr["tasks"].length
    i = 0
    while ( i < total_tasks )
        if ( arr["tasks"][i]["task_id"] == id )
            arr["tasks"][i]["description"] = new_description
            arr["tasks"][i]["updated_at"] = Time.now.utc.iso8601
            break
        end
        i += 1
    end
    File.open(json_path, "w") do |f|
        f.write(JSON.pretty_generate(arr))
    end
end

def delete_task(id, json_path)
    id = id.to_i
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
end

def update_task_status(id, status_action, json_path)
    id = id.to_i
    arr = JSON.parse(File.read(json_path))
    total_tasks = arr["tasks"].length
    i = 0
    while ( i < total_tasks )
        if ( arr["tasks"][i]["task_id"] == id )
            case status_action 
            when "mark-in-progress"
                arr["tasks"][i]["status"] = "in-progress"
            when "mark-done"
                arr["tasks"][i]["status"] = "done"
            end
        end

        i += 1
    end

    File.open(json_path, "w") do |f|
        f.write(JSON.pretty_generate(arr))
    end
end

def list_task(status, json_path)
    arr = JSON.parse(File.read(json_path))
    total_tasks = arr["tasks"].length
    case status
    when NilClass
        i = 0
        while ( i < total_tasks )
            puts arr["tasks"][i]

            i += 1
        end
    when "done"
        i = 0
        while ( i < total_tasks )
            if ( arr["tasks"][i]["status"] == "done" )
                puts arr["tasks"][i]
            end

            i += 1
        end
    when "in-progress"
        i = 0
        while ( i < total_tasks )
            if ( arr["tasks"][i]["status"] == "in-progress" )
                puts arr["tasks"][i]
            end

            i += 1
        end
    when "to-do"
        i = 0
        while ( i < total_tasks )
            if ( arr["tasks"][i]["status"] == "to-do" )
                puts arr["tasks"][i]
            end

            i += 1
        end
    else
        instructions()
    end
end

def instructions()
    puts "USAGE: ruby main.rb COMMAND"
    puts "COMMANDS: "
    puts "    add {TASK_DESCRIPTION}"
    puts "    update {TASK_ID} {NEW_TASK_DESCRIPTION}"
    puts "    delete {TASK_ID}"
    puts "    mark-in-progress {TASK_ID}"
    puts "    mark-done {TASK_ID}"
    puts "    list"
    puts "    list { done | to-do | in-progress }"
end
