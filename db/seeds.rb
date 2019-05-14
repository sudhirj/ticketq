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
# academy = Venue.create_or_find_by! slug: 'music-academy'
# academy.update_attributes! name: 'Music Academy', area: 'TTK Road', map_link: 'https://goo.gl/maps/38biWHgJKzAvBd2r8', image: 'SKctLgwLjSaDSWug'

kuku = Company.create_or_find_by! slug: 'kuku-company'
kuku.update_attributes! name: 'The Kuku Company', rp_account: 'acc_7oRhJRK7HO4IDJ', logo: 'uEsMcMieHL1tZuv7', contact_email: 'contact@kukucompany.com'

company = kuku.shows.create_or_find_by! slug: 'company'
company.update_attributes! name: 'COMPANY', tagline: 'A Musical Comedy', poster: 'ZXo1Ku1K3dHJNPkE', logo: 'dfNk545pcpd5eSYz'
company.update_attributes!(
  runtime_hours: 2,
  runtime_minutes: 0,
  intermission: true,
  cast: [
    { name: 'Sandeep John', photo: 'GzvBKa5yPeuGH1NS' },
    { name: 'Dr Yohan Chacko', photo: 'FcntDnEzN5PqT4hP' },
    { name: 'Pallavi V', photo: 'ZKYMSS99rQLN9bTX' },
    { name: 'Navarre Roy', photo: 'E7GgFL7TBxpfrVjj' },
    { name: 'Kavya Joseph', photo: 'byVgw2adf9afZF8s' },
    { name: 'Freddy Koikaran', photo: 'JYgbySTG9qM94CD8' },
    { name: 'Kamatchi', photo: 'HqXDZ8wfgLP3axwA' },
    { name: 'Gayathri Pradeep', photo: '1RPcJeVsx155ewbt' },
    { name: 'Ananth Bhaskararaman', photo: 'Sjy93Tky9iKHqNHF' },
    { name: 'Deepa Nambiar', photo: 'kzV2q8Qru1Kc6G77' },
    { name: 'Denver Anthony Nicholas', photo: 'ToLPcrp1uQRT5TA6' },
    { name: 'Aishvarrya', photo: '2nDuL1swUVjXeALv' },
    { name: 'Sangita Santosham', photo: 'kEQxtbLzRHA44rYE' },
    { name: 'Amrita Fredrick', photo: 'SAmgYCTgVCy7krTC' }
  ],
  crew: [
    { name: 'Amrita Fredrick', role: 'Director' },
    { name: 'Sangita Santosham', role: 'Vocal Director' },
    { name: 'Srikanth Gananasekaran', role: 'Pianist' }
  ],
  warning: 'COMPANY is not recommended for children under the age of 13 - contains adult themes and profanity.',
  about: [
    'COMPANY follows Bobby, a commitment phobic 35 year old through a musical dissection of love and relationships. Aided by the advice of his 5 married couple friends, Bobby juggles the pros and cons of marriage with endearing scepticism that will have audiences laughing and nodding in recognition.',
    'There will be a Q&A session with the cast and musicians on SATURDAY & SUNDAY after the show.'
  ],
  terms: [
    'Please pick up tickets from the box-office 30 minutes before showtime.',
    'Once tickets are purchased there will be no refunds or cancellations.',
    'This show contains adult themes and profanity and is not recommended for children under the age of 13.'
  ]
)

# perfs = []
# perfs << company.performances.create!(venue: museum, showtime: DateTime.parse('2019-06-07T19:30:00+05:30'))
# perfs << company.performances.create!(venue: museum, showtime: DateTime.parse('2019-06-08T18:30:00+05:30'))
# perfs << company.performances.create!(venue: museum, showtime: DateTime.parse('2019-06-09T18:30:00+05:30'))
#
#
# perfs.each do |perf|
#   denoms = []
#   denoms << perf.denominations.create!(price: 1000, name: 'Royal Stalls')
#   denoms << perf.denominations.create!(price: 500, name: 'Centre Gallery')
#   denoms << perf.denominations.create!(price: 300, name: 'Side Gallery')
# end
