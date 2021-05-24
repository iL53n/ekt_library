class FilterBooks
  attr_accessor :initial_scope

  QUANTITY_INDEX = 8
  DATA_LIST = { booking: ['booking', true],
                reading: ['reading', true],
                readed: ['reading', false],
                wishes: ['wish', false] }.freeze
  CHARACTER = { new: [], popular: [], top: [], commented: [] }.freeze

  def initialize(initial_scope, current_user, params)
    @initial_scope = initial_scope
    @current_user = current_user
    @params = params
  end

  def call(params)
    books = filter(initial_scope)
    by_categories(books)
  end

  private

  def by_categories(scope)
    categories = @params[:category_ids]

    if categories.nil?
      scope
    else
      scope.includes(:categories)
           .where(categories: { id: categories })
    end
  end

  def filter(initial_scope)
    filter = @params[:filter].to_sym

    if DATA_LIST.keys.include?(filter)
      return_filtered_arr_by_posts(DATA_LIST[filter][0], DATA_LIST[filter][1])
    elsif CHARACTER.keys.include?(filter)
      return_arr_by_character(filter)
    else
      initial_scope
    end
  end

  def return_filtered_arr_by_posts(title, active)
    initial_scope.joins(:posts).where(posts: { title: title,
                                               user: @current_user,
                                               active: active })
  end

  def return_arr_by_character(filter)
    case filter
    when :new
      new
    when :popular
      popular
    when :top
      top
    when :commented
      commented
    else
      # type code here
    end
  end

  def new
    sort_by_method(initial_scope, :created_at)
  end

  def popular
    books = initial_scope.joins(:posts).where(posts: { title: 'reading', active: false })
    sort_by_method(books, :calculate_readed)
  end

  def top
    books = initial_scope.joins(:ratings).where.not(ratings: nil)
    sort_by_method(books, :calculate_rating)
  end

  def commented
    books = initial_scope.joins(:comments).where.not(comments: nil)
    sort_by_method(books, :calculate_commented)
  end

  # def books_scope(joins_table, condition)
  #   initial_scope.joins(joins_table).where(joins_table: condition)
  # end

  def sort_by_method(scope, method)
    scope.sort_by { |item| item.send(method) } .uniq.last(QUANTITY_INDEX)
  end
end