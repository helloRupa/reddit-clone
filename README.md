# Reddit Clone
Ruby 3.3.4, Rails 6.0.4.8

https://cryptic-cove-63443.herokuapp.com/

## Features
- Account creation and deletion
- Sub/Post creation and deletion
- Comment on posts and comments
- Vote on posts and comments
- Embed external web pages (via onebox gem)

## Description
Unlogged-in users can view content but can't participate. Registered users can create and moderate subs, post and comment. Posts can belong to multiple subs.

## Moderator priveleges
A user marked as a sub's moderator may delete posts and comments on any that appear within their sub/s. This action is available on post#show page only.

## Deletion
- Subs cannot be deleted from the front-end or through the controller.
- Posts can be fully deleted - including their comments.
- Deleted comments are reassigned to the deleted account and their content is replaced with 'comment deleted'. This prevents the comment thread from being disrupted. When posts are deleted, comments are  destroyed instead.
- Deleted users will have their account name removed. Any subs, posts, or comments will be assigned to the deleted account with their content intact.

For deletion to work, an accunt named 'deleted' must be created. It doesn't need to be activated.

## Comments
There are 2 comment styles available in the app code: classic and flat. The app currently uses flat comments.

Classic comments are similar to Reddit's threaded comments. They have not yet been styled however, though the threading is visible.

The method #formatted_comments can be found in the comments helper.

## Run Project
1. `bundle install`
2. `bundle exec rails db:create`
3. `bundle exec rails db:seed`
4. `rails s`