# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

home = HomeConfiguration.new
slide1 = home.sliders.build
image1 = slide1.build_image
File.open('./public/projects/slider_default.jpg') do |f|
  image1.image = f
end
slide1.title = "Slider"

slide2 = home.sliders.build
image2 = slide2.build_image
File.open('./public/projects/slider_default.jpg') do |f|
  image2.image = f
end
slide2.title = "Slider"

slide3 = home.sliders.build
image3 = slide3.build_image
File.open('./public/projects/slider_default.jpg') do |f|
  image3.image = f
end
slide3.title = "Slider"

home.save
