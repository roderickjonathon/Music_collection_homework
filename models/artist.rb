require("pry")
require('pg')
require_relative("../db/sql_runner.rb")

class Artist
attr_accessor :id
attr_reader :name
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end


  def save()

    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    id_string = result[0]['id']
    @id = id_string.to_i

  end


  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end


  def self.all()
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map { |person| Artist.new(person) }
  end

  def albums()
      sql = "SELECT * FROM albums WHERE artist_id = $1"
      values = [@id]
      result = SqlRunner.run(sql, values)
      return result.map { |album| Album.new(album) }
  end

end
