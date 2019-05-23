require("pry")
require('pg')
require_relative("../db/sql_runner.rb")
require_relative("../models/artist.rb")

class Album
attr_accessor :id
attr_reader :name, :genre
  def initialize(options)
    @name = options['name']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end


  def save()
    sql = "INSERT INTO albums (name, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@name, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i

  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    album_hashes = SqlRunner.run(sql)
  albums = album_hashes.map { |albums| Album.new(albums)}
  return albums
  end


    def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)[0]
    return Artist.new(result)

  end



end
