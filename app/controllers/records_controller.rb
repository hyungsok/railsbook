class RecordsController < ApplicationController

  def index
  end

  def find
    @books = Book.find([2, 5, 10])
    render 'books/index'
  end

  def find_by
    @book = Book.find_by(publish: '제이펍')
    render 'books/show'
  end

  def find_by2
    @book = Book.find_by(publish: '제이펍', price: 2919)
    render 'books/show'
  end

  def where
    # @books = Book.where(publish: '제이펍').order(published: :desc)
    @books = Book.where(publish: '제이펍')
    # @books = Book.where(publish: '제이펍', price: 33600)
    # @books = Book.where(published: '2013-06-01'..'2013-12-31')
    # @books = Book.where(publish: ['제이펍', '한빛미디어'])
    render 'books/index'
  end

  def where2
    @books = Book.all
    @books.where!(publish: '제이펍')
    @books.order!(:published)
    render 'books/index'
  end

  def ph1
    @books = Book.where('publish = ? AND price >= ?', params[:publish], params[:price])
    # @books = Book.where('publish = :publish AND price >= :price', publish: params[:publish], price: params[:price])
    render 'books/index'
  end

  def not
    @books = Book.where.not(isbn: params[:id])
    render 'books/index'
  end

  def order
    @books = Book.where(publish: '제이펍').order(published: :desc)
    # @books = Book.where(publish: '제이펍').order(published: :desc, price: :asc)
    # @books = Book.where(publish: '제이펍').order(published: :desc, :price)
    render 'books/list'
  end

  def reorder
    # @books = Book.order(:publish).order(:price)
    # 앞에있는 order의 데이터를 날려준다.
    @books = Book.order(:publish).reorder(:price)
    # @books = Book.order(:publish).reorder(nil)
    render 'books/index'
  end

  def select
    @books = Book.select(:isbn, :title, :price).where('price >= 20000')
    render 'books/index'
  end

  def select2
    @pubs = Book.select(:publish).distinct.order(:publish)
    # @pubs = Book.select(:publish).distinct.distinct(false)
    render html: @pubs
  end

  def offset
    @books = Book.order(published: :desc).limit(3).offset(4)
    render 'books/index'
  end

  def page
    # records/page/4
    page_size = 3
    page_num = params[:id] == nil ? 0 : params[:id].to_i - 1
    @books = Book.order(published: :desc).limit(page_size).offset(page_size * page_num)
    render 'books/index'
  end

  def last
    @book = Book.order(published: :desc).last
    # @book = Book.order('published DESC').limit(3).last
    render 'books/show'
  end

  def groupby
    @books = Book.select('publish, AVG(price) AS avg_price').group(:publish)
  end

  def havingby
    @books = Book.select('publish, AVG(price) AS avg_price').group(:publish).having('AVG(price) >= ?', 25000)
    # having('AVG(price) >= :price', price: 25000)
    render 'records/groupby'
  end

  def unscope
    @books = Book.where(publish: '제이펍').order(:price).select(:isbn, :title).unscope(:where, :select)
    render 'books/index'
  end

  def unscope2
    @books = Book.where(publish: '제이펍', cd: true).order(:price).unscope(where: :cd)
    render 'books/index'
  end

  # records/none/all, new, cheap ...
  def none
    case params[:id]
      when 'all'
        @books = Book.all
      when 'new'
        @books = Book.order('published DESC').limit(5)
      when 'cheap'
        @books = Book.order(:price).limit(5)
      else
        @books = Book.none
    end
    render 'books/index'
  end

  def pluck
    render html: Book.where(publish: '제이펍').pluck(:title, :price)
  end

  def exists
    title = '제이펍'
    flag = Book.where(publish: title).exists?
    # flag = Book.exists?(1)
    # flag = Book.exists?(['price > ?', 50000])
    # flag = Book.exists?(publish: '제이펍')
    # flag = Book.exists?
    render html: "#{title} 존재하나요?: #{flag}"
  end

end
