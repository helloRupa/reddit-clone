module CommentsHelper
  def comments_hash(comments)
    hash = Hash.new { |h, k| h[k] = [] }

    comments.each { |c| hash[c.parent_comment_id] << c }
    hash
  end

  def nested_comments(comments)
    return nil if comments.empty?
    hash = comments_hash(comments)
    inner_comments(hash, nil).html_safe
  end

  def inner_comments(hash, comment_id)
    str = ''
    return str unless hash.key?(comment_id)

    hash[comment_id].each do |comment|
      str += '<div class="indent">' + render("comments/single_comment", comment: comment)
      str += inner_comments(hash, comment.id) + '</div>'
    end
    str
  end
end
