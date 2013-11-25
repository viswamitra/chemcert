# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#create student courses
student_courses = StudentCourse.create([{type_name: 'Initial'},{type_name: 'Refresher'},{type_name: 'AFQ II'},{type_name: 'AFQ IV'}])
addition_modules = AdditionalModule.create([{type_name: 'weeds'}])