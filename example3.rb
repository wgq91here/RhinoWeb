my_system = Rhino::Application.new

my_system::config {
  db = []
}


my_system::config.add do
  set :name, 'My System'
end

my_system::auth do
  enable :cookie, true
  set :user, {
      :ext_fields => ['int:age:scope(1..2)']
  }
end

my_system::event do

end

my_system::data do
  set :blogs, {
      :model => 'blog',
      :fields => 'title,content',
      :condition => ''
  }
  set :all_blogs, {
      :model => 'blog'
      # default is all fields
  }
end

my_system::modle do
  set :blog, {
      :table_name => 'blog',
      :fields => [
          # id etc. auto
          'string:title:50:not_empty',
          'text:content:not_empty',
      # update and create timestamp auto
      ]
  }
end

my_system::widget do
  df :login do
    # default find template string , file -> 'wg_#{widget_name}'
    :template_file => 'wg_login'
    # wg_login.rb
    #
    #
  end

  df :nav_blog do
  end

  df :form_blog do

  end

  df :list_blog do
    :data => 'blogs'
    :buildin_template => 'table',
        :pager => true
  end
end

my_system::widget.add do
  df :about_me do
    '' '
    i am RhinoWeb.
    ' ''
  end
end

my_system::page do
  df :login, {
      :layout => '1L',
      :wg_1L => [:login]
  }

  df :blog, {
      :auth => true,
      #:rule = ''
      :layout => '3W',
      :wg_3W => [:nav_blog, list_blog, nil]
  }
end

my_system::page.add do
  :about_me = {
      :layout = '2L',
      :wg_2L = ['nav', 'about_me']
  }
end

#...

my_system.run!
#or
my_system.update!
#or
my_sytem.generate!
