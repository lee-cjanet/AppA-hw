require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    #following are two diff properties
    self.type_translation = true
    #makes sure any type of data we get back is the same data type we passed in
    #if we pass in string, we want to get back string, not integer
    self.results_as_hash = true
    #makes sure the data coming in is in a hash
    #key = column, value = data stored in that column
  end
end

class Play
  #the attr_accessor will let us use the create & update method
  attr_accessor :title, :year, :playwright_id

  def self.all #will show every entry we have in our PLAY database

    #data = PlayDBConnection.instance (grabs database for us)
    # ("SELECT * FROM plays") pass in our query
    #the ABOVE text itself will return an ARRAY of HASHES where each hash represent a row in the DB

    #implementing ORM
    #want to return an ARRAY of play class INSTANCES
    #data.map

    data = PlayDBConnection.instance.execute("SELECT * FROM plays") #grabs database for us using singleton
    #SINGLETON b/c there is only ONE/same database

    data.map { |datum| Play.new(datum) }
    #implementing ORM
    #want to return an ARRAY of play class INSTANCES
    #data.map to pump into the initialize method below
    #throw all information from data into Play.new to process the information
  end

  def initialize(options)
    #initialize will PULL information out of OPTIONS HASH into instance variables listed below

    #options hash is nice b/c it will either will be DEFINED from the information pulled from the DB in self.all or set to NIL (if person inserts new info at initialize)

    @id = options['id']
    #ID may or may not be defined depending on DB
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create #save the instance to our database
    #everything in execute() is a string. heredoc
    raise "#{self} already in database" if @id
    #check if data is already in our system
    #if ID is defined

    #create SQL query
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    #SQL injection attacks
    #escapes any character that might be dangerous
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update #in case we make a mistake & want to update our table
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end
