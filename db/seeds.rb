# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_1 = User.create(email: 'user1@test.com',
                     password: '123456',
                     first_name: 'Иван',
                     last_name: 'Иванов')
user_2 = User.create(email: 'user2@test.com',
                     password: '123456',
                     first_name: 'Сергей',
                     last_name: 'Сергеев')
admin = User.create(email: 'admin@test.com',
                    password: '123456',
                    first_name: 'ИмяАдмин',
                    last_name: 'ФамилияАдмин',
                    admin: 'true')
category1 = Category.create(title: 'Бизнес')
category2 = Category.create(title: 'Менеджмент')

book1 = Book.create(title: 'Стартап без бюджета',
                    author: 'Майк Микаловиц',
                    description: '«Никогда в жизни не занимались предпринимательством? Не знаете где взять стартовый...',
                    status: 'available',
                    categories: [category1])
book2 = Book.create(title: 'Доставляя счастье',
                    author: 'Тони Шей',
                    description: 'Тони Шеи делится с читателями своим опытом ведения бизнеса, причем этот опыт поражает...',
                    status: 'available',
                    categories: [category1])
book3 = Book.create(title: 'От хорошего к великому.',
                    author: 'Джим Коллинз',
                    description: 'В этой книге подробно описывается процесс создания так называемых «голубых океанов»—...',
                    status: 'available',
                    categories: [category1, category2])