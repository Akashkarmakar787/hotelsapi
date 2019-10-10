json.array! @users do |user|
	json.username user.username
	json.email user.email
end