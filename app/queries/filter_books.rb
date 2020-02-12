class FilterBooks
  attr_accessor :initial_scope
  
  DATA_LIST = { booking: ['booking', true],
                reading: ['reading', true],
                readed: ['reading', false],
                wishes: ['wish', false] }.freeze

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
      return_filtered_arr(DATA_LIST[filter][0], DATA_LIST[filter][1])
    else
      initial_scope
    end
  end

  def return_filtered_arr(title, active)
    initial_scope.joins(:posts).where(posts: { title: title,
                                               user: @current_user,
                                               active: active })
  end
end