# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')
User.create! login: 'Test User',     name: 'test',  password: 'test',  password_confirmation: 'test'
User.create! login: 'Administrator', name: 'admin', password: 'admin', password_confirmation: 'admin'
