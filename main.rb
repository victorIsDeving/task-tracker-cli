require "json"

json_path = "./tasks.json"

if ( ARGV.length == 0 )
    puts "Usage: ruby main.rb COMMAND"
    puts "More info: ruby main.rb HELP"
end

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
    puts arr
end

