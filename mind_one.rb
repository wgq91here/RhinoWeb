module Rh
  def df(sym)
    puts sym.to_s
    yield
  end

  def set(sym, value)
    puts sym
    puts value
  end

  #Config = config
  module RConfig
      def add
        yield
      end
  end

end

my_system = Rh
puts my_system
puts my_system::RConfig


my_system::RConfig.add do
  df :blog do
    set :auth, true
    #:rule = ''
    layout = '3W'
    wg_3W = [:nav_blog, :list_blog, nil]
    wg_3W
  end
end
