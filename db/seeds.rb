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

Booking.delete_all
Allocation.delete_all
Denomination.delete_all
Performance.delete_all

perfs = []
perfs << company.performances.create!(venue: museum, showtime: rand(100..10000).minutes.from_now)
perfs << company.performances.create!(venue: academy, showtime: rand(100..10000).minutes.from_now)
perfs << company.performances.create!(venue: museum, showtime: rand(100..10000).minutes.from_now)
perfs << company.performances.create!(venue: museum, showtime: rand(100..10000).minutes.from_now)
perfs << lesmis.performances.create!(venue: academy, showtime: rand(100..10000).minutes.from_now)
perfs << lesmis.performances.create!(venue: academy, showtime: rand(100..10000).minutes.from_now)
perfs << lesmis.performances.create!(venue: academy, showtime: rand(100..10000).minutes.from_now)
perfs << lesmis.performances.create!(venue: academy, showtime: rand(100..10000).minutes.from_now)
perfs << lesmis.performances.create!(venue: academy, showtime: rand(100..10000).minutes.from_now)

perfs.each do |perf|
  denoms = []
  denoms << perf.denominations.create!(price: [300, 500].sample, name: 'Gold')
  denoms << perf.denominations.create!(price: [1500, 2500, 1000].sample, name: 'Platinum')
  denoms << perf.denominations.create!(price: [50, 150, 750].sample, name: 'Silver')
  denoms.each do |denom|
    denom.allocations.create! count: rand(100..500)
  end
end