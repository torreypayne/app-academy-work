# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
sebastian = User.create!(username: 'Sebastian', password: 'password')
torrey = User.create!(username: 'Torrey', password: 'password')

sub1 = Sub.create!(title: "Sub1", description: "Boring", moderator_id: sebastian.id)
sub2 = Sub.create!(title: "Sub2", description: "Little less boring", moderator_id: torrey.id)

post1 = Post.create!(title: "Boring post 1", author_id: sebastian.id)
post2 = Post.create!(title: "Boring post 2", author_id: torrey.id)
post3 = Post.create!(title: "Not so boring post 1", author_id: sebastian.id)
post4 = Post.create!(title: "Not so boring post 2", author_id: torrey.id)

postsub1 = PostSub.create!(sub_id: sub1.id, post_id: post1.id)
postsub2 = PostSub.create!(sub_id: sub1.id, post_id: post2.id)
postsub3 = PostSub.create!(sub_id: sub2.id, post_id: post3.id)
postsub4 = PostSub.create!(sub_id: sub2.id, post_id: post4.id)

post_comment1 = Comment.create!(content: "example 1", author_id: sebastian.id, commentable_type: "Post", commentable_id: post1.id)
nested_comment1 = Comment.create!(
 content: "comment on example 1",
 author_id: sebastian.id,
 commentable_type: "Comment",
 commentable_id: post_comment1.id,
 parent_comment_id: post_comment1.id
 )
