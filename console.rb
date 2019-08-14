require('pry')

require_relative('./models/artist')
require_relative('./models/album')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => 'Twinnie'})
artist2 = Artist.new({'name' => 'Maisie'})
artist3 = Artist.new({'name' => 'John'})
artist1.save()
artist2.save()
artist3.save()


album1 = Album.new({
  'title' => 'Social Babies',
  'genre' => 'Country',
  'artist_id' => artist1.id
  })

album1.save()

album2 = Album.new({
  'title' => 'Star',
  'genre' => 'Pop',
  'artist_id' => artist1.id
  })

album2.save()

album3 = Album.new({
  'title' => 'Moon',
  'genre' => 'Pop',
  'artist_id' => artist1.id
  })

album3.save()

Artist.find(artist1.id)
p album1.id

album1.title = "New"
album1.update()

artist1.name = "Amanda"
artist1.update()

binding.pry
nil
