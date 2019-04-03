# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

museum = Venue.create_or_find_by! slug: 'museum-theatre'
museum.update_attributes! name: 'Museum Theatre', area: 'Egmore'
academy = Venue.create_or_find_by! slug: 'music-academy'
academy.update_attributes! name: 'Music Academy', area: 'TTK Road'

kuku = Company.create_or_find_by! slug: 'the-kuku-company'
kuku.update_attributes! name: 'The Kuku Company'

company = kuku.shows.create_or_find_by! slug: 'company'
company.update_attributes! name: 'Company', tagline: 'A Musical Comedy'
lesmis = kuku.shows.create_or_find_by! slug: 'lesmis'
lesmis.update_attributes! name: 'Lés Miserables', tagline: 'The GLUMS!'

Performance.delete_all
company.performances.create! venue: museum, showtime: rand(100..10000).minutes.from_now
company.performances.create! venue: academy, showtime: rand(100..10000).minutes.from_now
company.performances.create! venue: museum, showtime: rand(100..10000).minutes.from_now
company.performances.create! venue: museum, showtime: rand(100..10000).minutes.from_now
lesmis.performances.create! venue: academy, showtime: rand(100..10000).minutes.from_now
lesmis.performances.create! venue: academy, showtime: rand(100..10000).minutes.from_now
lesmis.performances.create! venue: academy, showtime: rand(100..10000).minutes.from_now
lesmis.performances.create! venue: academy, showtime: rand(100..10000).minutes.from_now
lesmis.performances.create! venue: academy, showtime: rand(100..10000).minutes.from_now

