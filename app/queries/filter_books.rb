class FilterBooks
  attr_accessor :initial_scope

  def initialize(initial_scope, current_user, params)
    @initial_scope = initial_scope
    @current_user = current_user
    @params = params
  end

  def call(params)
    books = filter(initial_scope)
    books
  end

  private

  def filter(initial_scope)
    case @params[:filter]
    when 'all'
      initial_scope
    when 'booking'
      booking
    when 'wishes'
      wishes
    else
      initial_scope
    end
  end

  def booking
    initial_scope.joins(:posts).where(posts: { title: 'booking', user: @current_user, active: true })
  end

  def wishes
    initial_scope.joins(:posts).where(posts: { title: 'wish', user: @current_user })
  end
end