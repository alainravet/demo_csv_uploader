# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Account.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('accounts')

test  = User.create! name: 'Test User',     login: 'test',  password: 'test',  password_confirmation: 'test'
admin = User.create! name: 'Administrator', login: 'admin', password: 'admin', password_confirmation: 'admin'

admin.account.balance = 10_000

