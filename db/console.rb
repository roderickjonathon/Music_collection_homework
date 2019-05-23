require('pry')
require_relative('../models/album.rb')
require_relative('../models/artist.rb')

Album.delete_all()
Artist.delete_all()


artist1 = Artist.new({
  'name' => 'Jimi Hendrix'
  })

artist2 = Artist.new({
  'name' => 'Bob Marley'
  })


artist1.save()
artist2.save()


all_artists = Artist.all()


album1 = Album.new({
  'name' => 'Electric Ladyland',
  'genre' => 'Psychedelic Rock',
  'artist_id' => artist1.id
  })

album2 = Album.new({
  'name' => 'Live at Woodstock',
  'genre' => 'Blues/rock',
  'artist_id' => artist1.id
  })

album1.save()
album2.save()


all_albums = Album.all()

artist1.albums()
album1.artist()

binding.pry
nil
