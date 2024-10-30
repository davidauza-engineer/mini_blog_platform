# frozen_string_literal: true

require 'factory_bot_rails'

# Create default users
users = [
  { name: "Alice", email: "alice@example.com", password: "password" },
  { name: "Bob", email: "bob@example.com", password: "password" },
  { name: "Charlie", email: "charlie@example.com", password: "password" }
]

users.each do |user_data|
  User.find_or_create_by!(email: user_data[:email]) do |user|
    user.name = user_data[:name]
    user.password = user_data[:password]
  end
end

# Create default posts
posts = [
  { title: "First Post", body: "This is the first post.", user: User.find_by(email: "alice@example.com") },
  { title: "Second Post", body: "This is the second post.", user: User.find_by(email: "bob@example.com") },
  { title: "Third Post", body: "This is the third post.", user: User.find_by(email: "charlie@example.com") }
]

posts.each do |post_data|
  Post.find_or_create_by!(title: post_data[:title]) do |post|
    post.body = post_data[:body]
    post.author = post_data[:user]
  end
end

# Create default comments
comments = [
  { body: "Great post!", post: Post.find_by(title: "First Post"), author: User.find_by(email: "bob@example.com") },
  { body: "Very informative.", post: Post.find_by(title: "Second Post"), author: User.find_by(email: "charlie@example.com") },
  { body: "Thanks for sharing!", post: Post.find_by(title: "Third Post"), author: User.find_by(email: "alice@example.com") }
]

comments.each do |comment_data|
  Comment.find_or_create_by!(body: comment_data[:body], post: comment_data[:post], author: comment_data[:author])
end
