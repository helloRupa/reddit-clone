module PostsHelper
  def upvote_percentage(post)
    total_votes = post.votes.length
    return 0 if total_votes.zero?

    score = post.vote_total * 1.0
    if score > 0
      ( ( (total_votes - score) / 2 ) + score ) / total_votes * 100
    else
      ( (total_votes + score) / 2 ) / total_votes * 100
    end
  end
end