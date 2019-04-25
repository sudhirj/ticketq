# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

museum = Venue.create_or_find_by! slug: 'museum-theatre'
museum.update_attributes! name: 'Museum Theatre', area: 'Egmore', map_link: 'https://goo.gl/maps/38biWHgJKzAvBd2r8', image: 'SKctLgwLjSaDSWug'
academy = Venue.create_or_find_by! slug: 'music-academy'
academy.update_attributes! name: 'Music Academy', area: 'TTK Road', map_link: 'https://goo.gl/maps/38biWHgJKzAvBd2r8', image: 'SKctLgwLjSaDSWug'

kuku = Company.create_or_find_by! slug: 'kuku-company'
kuku.update_attributes! name: 'The Kuku Company', rp_account: 'acc_7oRhJRK7HO4IDJ', logo: 'uEsMcMieHL1tZuv7'

company = kuku.shows.create_or_find_by! slug: 'company'
company.update_attributes! name: 'COMPANY', tagline: 'A Musical Comedy', poster: 'JypDmVDvkhuE9E2Y'
company.update_attributes!(
  cast: [
    { name: 'Sandeep John' },
    { name: 'Dr Yohan Chacko' },
    { name: 'Pallavi V' },
    { name: 'Navarre Roy' },
    { name: 'Kavya Joseph' },
    { name: 'Freddy Koikaran' },
    { name: 'Kamatchi' },
    { name: 'Gayathri Pradeep' },
    { name: 'Ananth Bhaskararaman' },
    { name: 'Deepa Nambiar' },
    { name: 'Denver Anthony Nicholas' },
    { name: 'Aishvarrya' },
    { name: 'Sangita Santosham' },
    { name: 'Amrita Fredrick' }
  ],
  crew: [
    { name: 'Amrita Fredrick', role: 'Director' },
    { name: 'Sangita Santosham', role: 'Vocal Director' },
    { name: 'Hannah Elliot', role: 'Vocal Coach' },
    { name: 'Srikanth Gananasekaran', role: 'Pianist' }
  ],
  warning: 'COMPANY runs for 2 hours with an intermission. Not recommended for children under the age of 13 - contains adult themes and profanity.',
  about: [
    'COMPANY follows Bobby, a commitment phobic 35 year old through a musical dissection of love and relationships. Aided by the advice of his 5 married couple friends, Bobby juggles the pros and cons of marriage with endearing scepticism that will have audiences laughing and nodding in recognition.',
    'There will be a Q&A session with the cast and musicians on SATURDAY & SUNDAY after the show.'
  ],
  terms: [
    'Please pick up tickets from the box-office 30 minutes before showtime.',
    'Once tickets are purchased there will be no refunds or cancellations.'
  ]
)
lesmis = kuku.shows.create_or_find_by! slug: 'lesmis'
lesmis.update_attributes! name: 'Lés Miserables', tagline: 'The GLUMS!', poster: 'ZinJWAWPJswgjRqA'

Booking.delete_all
Allocation.delete_all
Denomination.delete_all
Performance.delete_all

perfs = []
perfs << company.performances.create!(venue: museum, showtime: DateTime.parse('2019-06-07T19:30:00+05:30'))
perfs << company.performances.create!(venue: museum, showtime: DateTime.parse('2019-06-08T18:30:00+05:30'))
perfs << company.performances.create!(venue: museum, showtime: DateTime.parse('2019-06-09T18:30:00+05:30'))

perfs << lesmis.performances.create!(venue: academy, showtime: rand(100..10_000).minutes.from_now)
perfs << lesmis.performances.create!(venue: academy, showtime: rand(100..10_000).minutes.from_now)
perfs << lesmis.performances.create!(venue: academy, showtime: rand(100..10_000).minutes.from_now)
perfs << lesmis.performances.create!(venue: academy, showtime: rand(100..10_000).minutes.from_now)
perfs << lesmis.performances.create!(venue: academy, showtime: rand(100..10_000).minutes.from_now)

perfs.each do |perf|
  denoms = []
  denoms << perf.denominations.create!(price: [300, 500].sample, name: 'Gold')
  denoms << perf.denominations.create!(price: [1500, 2500, 1000].sample, name: 'Platinum')
  denoms << perf.denominations.create!(price: [50, 150, 750].sample, name: 'Silver')
  denoms.each do |denom|
    denom.allocations.create! count: rand(100..500)
  end
end
