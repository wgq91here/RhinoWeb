rhino::application do
  define :main , {
    :name => "Simple Blog System",
  }

  enable :admin
  enable :authUser

  model :blog , {
    attrs {
      title string
      content text
      createDate date
      owner moudle/member #userid
      category category #use module category
      tag moudle/rtags #auto create tags->blogs *->* field,rule,etc.
    }
    event {
      beforeSave do
        time()
      end
    }    
  }

  auth :
      register true
      owner true
      profile true
      model Rhino::member
      extfield {
        googlemail mail, true #must
      }

end
rhino::application do
  {
    :main => {
      :name => "Simple Blog System",
      :title => "My Blog",
      :layer => "3L",
      :theme => "bootstrap"
    },
    :db => {
      :development => DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "t1_development.db")),
      :production  => DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "t1_production.db")),
      :test        => DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "t1_test.db"))
    },
    :admin => {
      :allow_ip => "127.0.0.1",
      :web_url => "/webAdmin",
      :admin_models => 'member, blog',
      :auth => load_user_name_password, # load_user_name_password(&username,&password,&salt)
      # or
      #:auth => {
      #  :name => 'admin',
      #  :password => 'admin'
      #  :salt => ''
      #}
    },
    :auth => {
      :root => {
        :name => 'admin',
        :password => 'admin'
      },
    },
    :model => {

    }
  }
end

#system admin manage
rhion::admin do
end

  def auth
    #system root Manager init and not include db.
    set :root, {
        :name => "admin",
        :passwd => "admin"
    }

    #member own allow system init
    #ex model
    authUser {
      register true
      owner true
      profile true
      model Rhino::member
      extfield {
        googlemail mail, true #must
      }
    }

    setting {

    }
  end

  rule {

  }

  def module

  end

  def event

  end

  def plugin
    {
        :modle => [
            :category => 'moudle/rcategory' #category id category->category_id 1->1 field,rule,etc.
        ]
    }
  end

  def page
    url 'index' do
    end

    url 'admin' do
    end

    blog {
      action ['list', 'list_category', 'update', 'delete', 'view']
    }

    album {
      action ['list', 'list_category', 'update', 'delete', 'view']
    }

    tag {
      action moudle/rtags # auto find relation model list view & cduv
    }

    category {
      action moudle/category
    }

  end

  modle {
    member do
      {
          model Rhion/member # add all Rhion redefined member fields
      friend moudle/friend # add friend ids
      }

      category do
        {
            model plugin/category
        }

        blog do
          attrs {
            title string
            content text
            createDate date
            owner moudle/member #userid
            category category #use module category
            tag moudle/rtags #auto create tags->blogs *->* field,rule,etc.
          }
          event {
            beforeSave do
              time()
            end
          }
          setting {
            :listNum => [
                :label => '', :selectFields => '10,20,30,#'
            ]
            :showOwn => [
                :label => 'Show Type',
                [
                    [:label => 'show by all', :allow => {true}, :action => '/blog.list~/'],
                    [:label => 'show by own', :deny => {session.userid != own.userid}, :action => 'blog.*'],
                    [:label => 'show by firends', :allow => {session.userid in own.firends }, :action => 'blog.list, blog.view']
          ]
          ]
          }
          }
        end

        album do
          attrs {
            title string
            createDate date
            owner moudle/user #userid
            category plugin/category #use module category
            pictureUrl moudle/uploadfile #uploadfile
          }
          event {
            beforeSave do
              time()
            end
            afterSave {}
            beforeInsert {}
            beforeDelete {}
          }
          setting {
            :albumWidth => [:label => 'album Width', :default => 200]
          }
        end
        }
