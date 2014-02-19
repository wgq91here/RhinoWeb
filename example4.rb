class App


  # 定义 应用
  # 定义 基本参数 包括
  #    名称、数据来源预定义
  config do
    add :app_name, 'Rhino'
    add :index_page, :index
    add :db, {
        :adapter => 'sqlite3',
        :database => Padrino.root('db', 'basfdemo_production.db')
    }
  end

  layout :main do
    template '3L'
  end

  model :owner do
    table_field :owners do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :crypted_password
      t.string :role
      t.timestamps
    end

    has_many :blog
    validates :title, presence: true
  end

  model :blog do
    #db :db
    #table_name :blog_items
    table_field :blog_items do |t|
    end

    has_one :owner
  end

  data :blog, [:source => :db] do
    model :blog, :find_all
  end

  data :nav, do
    [
        :page => :index,
        :widget_blog => :blog,
        :widget_about_me => :about_me
    ]
  end

  data :about_me do
    'about me'
  end

  widget :nav, do
    data :nav
    # template 带有 rhino 开头 将作为 系统预设模板实现
    template :rhino_nav
  end

  widget :about_me, do
    data :about_me
    #init {}
    #before_rendering {}
    #after_rendering {}
  end

  widget :blog, do
    data :blog
    template :rhino_grid, [:pageSize => 20]
  end

  # 定义 页
  # 页 中 可定义 页层、URL、块
  # 块 中 可定义 数据、模板、javascript脚本
  # 数据 中 可定义 模型、过滤器
  page :index, '/', do
    before {}
    after {}

    layout :main
    widget :nav, '1L'
    widget :blog, '2L'
    widget :about_me, '2L'
    widget :footer, '3L', do
      'RightCopy 2014'
    end

    layout :main
  end

end
