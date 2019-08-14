require('pry')
require('pg')

require_relative('./artist')

class Album

  attr_reader :artist_id
  attr_accessor :id, :title, :genre

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "
      INSERT INTO albums
      (
        title,
        genre,
        artist_id
        )
      VALUES
      ($1, $2, $3)
      RETURNING * "
    values = [@title, @genre, @artist_id]
    db.prepare("save", sql)
    db.exec_prepared("save", values)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def Album.all()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "
      SELECT * FROM albums"
    db.prepare("all", sql)
    result = db.exec_prepared("all")
    db.close()
    album = result.map { |album_hash| Album.new(album_hash) }
    return album
  end

  def artist()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    db.prepare("artist", sql)
    result = db.exec_prepared("artist", values)
    db.close()
    artist = result.map { |artist_hash| Artist.new(artist_hash) }
    return artist
  end

  def update()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "UPDATE albums
      SET (
        title,
        genre,
        artist_id
      ) =
        (
          $1, $2, $3
        )
        WHERE id = $4
        RETURNING * "
    values = [@title, @genre, @artist_id, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Album.delete_all()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "DELETE FROM albums"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def Album.find(id)
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    result = db.exec_prepared("find", values)
    db.close()
    album = result.map { |album_hash| Album.new(album_hash) }
    return album
  end

  def delete()
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

end
