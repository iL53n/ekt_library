class FilterBooks # ToDo: need refactoring
  attr_accessor :initial_scope

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

    if @params[:category_ids].nil?
      scope
    else
      books = []
      @params[:category_ids].each do |category_id|
        scope.each do |book|
          books.push(book) if book.category_ids.include?(category_id.to_i)
        end
      end
      books
    end
  end

  def filter(initial_scope)
    case @params[:filter]
    when 'all'
      initial_scope
    when 'booking'
      booking
    when 'reading'
      reading
    when 'readed'
      readed
    when 'wishes'
      wishes
    else
      initial_scope
    end
  end

  def booking
    return_arr('booking', true)
  end

  def reading
    return_arr('reading', true)
  end

  def readed
    return_arr('reading', false)
  end

  def wishes
    return_arr('wish', false)
  end

  def return_arr(title, active)
    initial_scope.joins(:posts).where(posts: { title: title,
                                               user: @current_user,
                                               active: active })
  end
end