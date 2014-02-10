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

  module RPages
    class Rhino_pages

      def add
        yield
      end

      def to_s
        puts self
      end

      def layout(layoutName)
        puts layoutName
      end
    end
  end

end

my_system = Rh

my_system::RConfig.add do
  df :blog do
    set :auth, true
    #layout '3W'
    #wg_3W  [:nav_blog, :list_blog, nil]
    #wg_3W
  end
end

my_system::RPages.add do
  df :index do
    layout '3W'
  end
end
