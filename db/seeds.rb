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
category3 = Category.create(title: 'Саморазвитие')
category4 = Category.create(title: 'Финансы')

Book.create(title: 'Стартап без бюджета',
            author: 'Майк Микаловиц',
            description: 'Эта книга для тех, у кого нет за плечами ангела с серьезной финансовой поддержкой. Она для тех, кто начинает свое дело с крайне ограниченными ресурсами. Для тех, кому первым офисом служит кофейня в центре города. Мы сами так когда-то начинали наш издательский бизнес. Эта книга незаменима для тех, кто растит стартап, для тех, кто собирается запустить стартап и терзается сомнениями, и для всех, кто хочет, чтобы его компания, уже не будучи стартапом, сохраняла свой драйв. Если вы уже прочитали Rework и Доставляя счастье, то это – ваша следующая книга.',
            image_src: 'https://cv1.litres.ru/pub/c/elektronnaya-kniga/cover_415/627515-mayk-mikalovic-startap-bez-budzheta.jpg',
            number_of: 5,
            categories: [category1])
Book.create(title: 'Доставляя счастье',
            author: 'Тони Шей',
            description: 'В этой книге собрано сразу несколько историй, одна зажигательнее другой. Автобиография одного из самых ярких молодых бизнесменов последнего времени, начавшего свой первый бизнес в девять лет. История развития его компании Zappos, за десять лет с нуля разогнавшейся до миллиардного оборота. А главное – рассказ о том, как Тони и его соратникам удалось построить бизнес, радующий своим существованием не только владельцев, но и всех причастных к компании – от сотрудников и клиентов до поставщиков и партнеров. Обо всех планах и пробах, ошибках и курьезах, принципах и заповедях Zappos – из первых рук и от первого лица.',
            image_src: 'https://cv8.litres.ru/pub/c/elektronnaya-kniga/cover_415/434585-toni-shey-dostavlyaya-schaste.jpg',
            number_of: 3,
            categories: [category1, category2])
Book.create(title: 'От хорошего к великому',
            author: 'Джим Коллинз',
            description: 'Как превратить среднюю (читай – хорошую) компанию в великую? На этот вопрос отвечает бестселлер «От хорошего к великому». В нем Джим Коллинз пишет о результатах своего шестилетнего исследования, в котором компании, совершившие прорыв, сравнивались с теми, кому это не удалось. У всех великих компаний обнаружились схожие элементы успеха, а именно: дисциплинированные люди, дисциплинированное мышление, дисциплинированные действия и эффект маховика. Благодаря этому компании добивались феноменальных результатов, превосходящих средние результаты по отрасли в несколько раз. Книга будет интересна собственникам бизнеса, директорам компаний, директорам по развитию, консультантам и студентам, обучающимся по специальности «менеджмент»..',
            number_of: 2,
            image_src: 'https://cv0.litres.ru/pub/c/elektronnaya-kniga/cover_415/23134201-dzhim-kollinz-ot-horoshego-k-velikomu.jpg',
            categories: [category1, category2])
Book.create(title: 'Scrum. Революционный метод управления проектами',
            author: 'Джефф Сазерленд',
            description: 'Методика Scrum – решение, найденное Джеффом Сазерлендом, чтобы преодолеть классические недостатки управления проектами: отсутствие слаженной работы внутри команды, невыполнение намеченных планов, дублирование задач внутри подразделений и т. д. В отличие от старого «поэтапного» подхода, при котором выбрасываются на ветер огромные средства и который зачастую так ни к чему не приводит, Scrum позволяет выполнять обязательства меньшими силами, в короткие сроки и с низкими затратами, а итоговый продукт отличается отменным качеством. Сегодня Scrum уже прочно закрепилась в управленческом арсенале большинства технологичных компаний мира. Теперь этот инструмент повышения продуктивности доступен и вам.',
            image_src: 'https://cv3.litres.ru/pub/c/elektronnaya-kniga/cover_415/11946933-dzheff-sazerlend-scrum-revolucionnyy-metod-upravleniya-proektami.jpg',
            number_of: 4,
            categories: [category1, category2, category3])
Book.create(title: 'Измеряйте самое важное',
            author: 'Джон Дорр',
            description: 'Система Objectives and Key Results предназначена для постановки приоритетных целей и грамотного управления текущими проектами. С ее помощью любой руководитель может определить ключевые цели для своего бизнеса в целом и для каждого из работников. Такой подход позволяет найти четкие ответы на важные вопросы: что необходимо делать прямо сейчас? Каких результатов надо достичь? Кто работает над поставленными целями?',
            image_src: 'https://cv9.litres.ru/pub/c/elektronnaya-kniga/cover_415/39473693-dzhon-dorr-izmeryayte-samoe-vazhnoe-kak-google-intel-i-drugie-kompanii-dob.jpg',
            number_of: 5,
            categories: [category1, category4])
Book.create(title: 'Никогда не ешьте в одиночку и другие правила нетворкинга',
            author: 'Кейт Феррацци, Тал Рэз',
            description: 'Связи решают все! Уже давно в Европе и Америке одним из главных навыков, в частности для предпринимателя и менеджера, считается нетворкинг – умение открыто и искренне общаться с самыми разными людьми, выстраивая сеть полезных знакомств. Автор этой книги, собравший в своей записной книжке более пяти тысяч контактов сильных мира сего, делится секретами построения широкой сети взаимовыгодных связей в бизнесе и не только. Следуя его советам, вы не только реализуете свои амбиции и способности и поможете кому-то сделать то же самое, но и, несомненно, украсите свою жизнь общением с интересными собеседниками.',
            number_of: 3,
            image_src: 'https://cv0.litres.ru/pub/c/elektronnaya-kniga/cover_415/591105-keyt-ferracci-nikogda-ne-eshte-v-odinochku-i-drugie-pravila-netvorkinga.jpg',
            categories: [category1, category3])
Book.create(title: 'Ген директора',
            author: 'Владимир Моженков',
            description: 'Сколько миллионов стоит улыбка? Как посадить правильных людей в свой автобус? Стоит ли держать друзей близко, а врагов еще ближе? Зачем выращивать в себе подвиганта? Об этом и многом другом – в реальных управленческих историях ведущего российского бизнес-практика, основателя «Ауди Центра Таганка» и ГК «АвтоСпецЦентр», лучшего менеджера «Ауди» в Европе по признанию концерна Audi AG Владимира Моженкова.',
            number_of: 2,
            image_src: 'https://cv0.litres.ru/pub/c/elektronnaya-kniga/cover_415/25234904-vladimir-mozhenkov-gen-direktora.jpg',
            categories: [category1, category2])
Book.create(title: 'Открывая организации будущего',
            author: 'Фредерик Лалу',
            description: 'Современные навыки управления безнадежно устарели. Традиционные рецепты, предлагаемые книгами по организационному развитию, оказываются частью проблемы, а не ее решением. Автор этой книги, основываясь на многолетнем глубоком исследовании, рассказывает, какими станут организации будущего, построенные на абсолютно иных принципах, – цельными, самоуправляемыми и эволюционными. Он показывает, как такие компании развиваются – и с нуля, и эволюционируя из существующих организаций.',
            number_of: 1,
            image_src: 'https://cv5.litres.ru/pub/c/elektronnaya-kniga/cover_415/12472950-frederik-lalu-otkryvaya-organizacii-buduschego.jpg',
            categories: [category1, category3])
Book.create(title: 'Scrum без ошибок',
            author: 'Илан Голдштейн',
            description: 'Широкое распространение Scrum объясняется его кажущейся простотой, однако его внедрение проходит далеко не так гладко, как ожидают многие. Опираясь на свой обширный опыт, сертифицированный scrum-тренер Илан Голдштейн раскрывает фундаментальные механизмы Scrum и его сущность как фреймворка. В этой книге каждый найдет решение своих проблем и конкретных scrum-задач. Даже те, кто разобрался во всех scrum-тонкостях и держит все под контролем, найдут для себя новые инструменты и добавят их в свой scrum-арсенал. В этой книге Илан Голдштейн собрал 30 лайфхаков. Написаны они таким образом, чтобы их можно было читать и использовать автономно, независимо от других частей книги. Обращайтесь к тем из них, которые больше всего отвечают вашим потребностям. И помните, что в этой книге отражена только реальная scrum-практика, протестированная в боевых условиях.',
            number_of: 1,
            image_src: 'https://cv3.litres.ru/pub/c/elektronnaya-kniga/cover_415/48446834-ilan-goldshteyn-scrum-bez-oshibok.jpg',
            categories: [category1, category2])
Book.create(title: 'Ускорение перемен',
            author: 'Джон П. Коттер',
            description: 'Книга развивает идеи, изложенные автором в статье, опубликованной в «Harvard Business Review» и получившей престижную премию компании McKinsey за прикладной характер и новаторское мышление в сфере бизнеса и управления. Джон Коттер призывает организации к созданию комбинированной системы управления, сочетающей проверенную временем, надежную и эффективную иерархическую организационную структуру с гибкой и динамичной сетевой структурой, схожей с устройством начинающей компании (стартапа). По мнению автора, комбинированная система управления предоставляет крупным, зрелым компаниям ключевой инструмент для того, чтобы соответствовать требованиям быстро меняющейся среды.',
            number_of: 1,
            image_src: 'https://cv3.litres.ru/pub/c/elektronnaya-kniga/cover_415/23322030-dzhon-kotter-uskorenie-peremen.jpg',
            categories: [category1, category4])
Book.create(title: 'Четвертая промышленная революция',
            author: 'Клаус Шваб',
            description: 'Мы стоим у истоков революции, которая фундаментально изменит то, как мы живем, работаем и общаемся друг с другом. По масштабу, объему и сложности четвертая промышленная революция не имеет аналогов во всем предыдущем опыте человечества. Нам предстоит увидеть ошеломляющие технологические прорывы в самом широком спектре областей, включая искусственный интеллект, роботизацию, автомобили-роботы, трехмерную печать, нанотехнологии, биотехнологии и многое другое.',
            number_of: 1,
            image_src: 'https://cv6.litres.ru/pub/c/elektronnaya-kniga/cover_415/21240265-klaus-shvab-chetvertaya-promyshlennaya-revoluciya-21240265.jpg',
            categories: [category1, category2])
