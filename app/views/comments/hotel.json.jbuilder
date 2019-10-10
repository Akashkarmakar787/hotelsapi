
json.array! @comments do |comment|
  	json.post comment.post
  	json.username comment.user.username
  	json.useremail comment.user.email
  end
  
