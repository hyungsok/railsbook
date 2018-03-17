class Post < ApplicationRecord
  # 이름(name)과 제목(title)을 가지고 있어야하고, 제목(title)은 최소 5글자 이상이라는걸 보장
  # p = Post.new(:content => "A new post")
  # p.save (error!)
  validates :name, :presence => true
  validates :title, :presence => true,
            :length => {:minimum => 5}

  # 하나의 글(Post)는 많은 댓글(comment)를 가질수 있다.
  # 관계된 객체 삭제하기
  has_many :comments, :dependent => :destroy
end
