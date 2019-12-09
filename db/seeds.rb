# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_1 = User.create(email: 'user1@test.com',
                     password: '123456',
                     first_name: 'FirstName1',
                     last_name: 'LastName1')
user_2 = User.create(email: 'user2@test.com',
                     password: '123456',
                     first_name: 'FirstName2',
                     last_name: 'LastName2')
admin = User.create(email: 'admin@test.com',
                    password: '123456',
                    first_name: 'FirstNameAdmin',
                    last_name: 'LastNameAdmin',
                    admin: 'true')

book1 = Book.create(title: 'Book1',
                    author: 'Author',
                    description: 'Description description description',
                    image: 'image',
                    status: 'ok')
book2 = Book.create(title: 'Book2',
                    author: 'Author',
                    description: 'Description description description',
                    image: 'image',
                    status: 'ok')
book3 = Book.create(title: 'Book3',
                    author: 'Author',
                    description: 'Description description description',
                    image: 'image',
                    status: 'ok')

category1 = Category.create(title: 'Category1')
category2 = Category.create(title: 'Category2')