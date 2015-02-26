# Use object-oriented Ruby to model a public library (w/ three classes:
# Library, Shelf, & Book). * The library should be aware of a number of shelves.
# Each shelf should know what books it contains.
# Make the book object have "enshelf" and "unshelf" methods that control what
# shelf the book is sitting on. The library should have a method to report
# all books it contains. Note: this should *not* be a Rails app - just a single
# file with three classes (plus commands at the bottom showing it works) is
# all that is needed. In addition to pushing this ruby file to your Github
# account, please also setup your code at http://repl.it/languages/Ruby
# (so it runs) and enter the saved URL here so we can take a look.

class Book
  attr_reader :title, :author
  def initialize(args)
    @title = args[:title]
    @author = args[:author]
    @shelfed = false
  end

  def enshelf(shelf)
    if @shelfed
      puts 'Book already exits on a shelf.  Please unshelf first.'
    else
      shelf.push(self)
      @shelfed = true
    end
  end

  def unshelf(shelf)
    shelf.delete(self)
    @shelfed = false
  end

  def to_s
    "#{title} by #{author}"
  end
end

class Shelf
  include Enumerable

  attr_reader :books, :name
  def initialize(name = 'New Shelf')
    @name = name
    @books = []
  end

  def push(value)
    books.push(value)
  end

  def delete(value)
    books.delete(value)
  end

  def each(&block)
    books.each(&block)
  end
end

class Library
  attr_reader :shelves
  def initialize(*shelves)
    @shelves = shelves
  end

  def add_shelf(shelf)
    if shelves.include?(shelf)
      puts 'That shelf already exits in this library!'
    else
      shelves.push(shelf)
    end
  end

  def remove_shelf(shelf)
    shelves.delete(shelf)
  end

  def list_books
    display = ''
    shelves.each do |shelf|
      display += "\n#{shelf.name}:\n"
      shelf.each do |book|
        display += (book.to_s + "\n")
      end
    end
    puts display.strip
  end
end

############################################################################

orange  = Book.new(title: 'A Clockwork Orange', author: 'Anthony Burgess')
strange = Book.new(title: 'The Stranger', author: 'Jean-Paul Sartre')

gadget  = Book.new(title: 'You Are Not A Gadget', author: 'Jaron Lanier')
outlier = Book.new(title: 'Outliers', author: 'Malcolm Gladwell')

shelf_one = Shelf.new('Fiction')
shelf_two = Shelf.new('Non-Fiction')

orange.enshelf(shelf_one)
strange.enshelf(shelf_one)

gadget.enshelf(shelf_two)
outlier.enshelf(shelf_two)

lib = Library.new(shelf_one, shelf_two)
lib.list_books
