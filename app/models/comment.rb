class Comment < ApplicationRecord
  # 각 댓글(comment)는 하나의 글(Post)에 속한다.
  belongs_to :post
end
