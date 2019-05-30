module UsersHelper
  def mixed_ordered_posts_comments(posts, comments)
    p_hash = post_hash(posts)
    c = comments.to_a

    c.each_with_index do |comment, idx|
      next unless p_hash.key?(comment.post_id)
      p_hash[comment.post_id] << comment
      c[idx] = nil
    end
    
    sort_posts_comments(p_hash, c)
  end  

  def post_hash(posts)
    h = {}
    posts.each { |post| h[post.id] = [post] }
    h
  end

  def sort_posts_comments(post_hash, comments_arr)
    post_hash.to_a.concat(comments_arr.reject(&:nil?)).sort_by do |el|
      el.is_a?(Array) ? el[1][0].created_at : el.created_at
    end
  end

  def separate_posts_comments(arr)
    [arr[1][0], arr[1][1..-1]]
  end

  def mix_posts_comments(posts, comments)
    posts.to_a.concat(comments.to_a).sort_by { |el| el.created_at }
  end
end
