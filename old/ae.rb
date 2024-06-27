def add_user(users, user)
  users[user[:id]] = user
end

def update_users(users)
  users.each do |id, user|
    user[:status] = "active"
    user[:last_login] = Time.now
    user[:login_count] += 1
    puts "Updated User ID #{id}: Status #{user[:status]}"
    user.keys.each { |key| puts "User #{key}: #{user[key]}" }  # Excessive output statements
    10.times { |i| user["key_#{i}"] = "value_#{i}" }  # Excessive key-value pair assignments
  end
end

def display_users(users)
  users.each { |id, user| puts "User ID #{id}, Name: #{user[:name]}" }
end
