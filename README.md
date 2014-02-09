RhinoWeb
========

RhinoWeb

Use by Ruby create a web application auto.

## Features

# Moudle
- Rhino_config 
- Rhino_auth 
- Rhino_event 
- Rhino_page 
- Rhino_widget 
- Rhino_data 
- Rhino_model

# Details
Rhino_config 
- db_connect 
- title 

Rhino_auth 
- user {groups} => Rhino_data
- rule  => Rhino_data

Rhino_event 
- 

## Usage

preview2:

```ruby
my_system = Rhino::Application.new

my_system::config {
  :db => []
}

my_system::config.add  {
  :name => 'My System'
}

my_system::auth {
  :enable => true ,
  :user => { :ext_fields => ['int:age:scope(1..2)']}
}

my_system::event {
  
}

my_system::data {
  :blogs => {
    :model 'blog',
    :fields 'title,content',
    :condition ''
  },
  :all_blogs {
    :model 'blog',
    # default is all fields     
  }
}

my_system::modle {
  :blog => {
    :table_name => 'blog',
    :fields =>[
      # id etc. auto 
      'string:title:50:not_empty',
      'text:content:not_empty',
      # update and create timestamp auto
    ]
  }
}

my_system::widget do
  :login {
    # default find template string , file -> 'wg_#{widget_name}'
    :template_file 'wg_login',
    # wg_login.rb
    # 
    # 
  },
  :nav_blog {

  },
  :form_blog {

  },  
  :list_blog {
    :data 'blogs',
    :buildin_template 'table'
    :pager true
  }
end

my_system::widget.add do
  :about_me = {
    '''
    i am RhinoWeb.
    '''
  }
end

my_system::page do
  :login = {
    :layout = '1L',
    :wg_1L = [:login]
  }
  :blog = {
    :auth = true,
    #:rule = ''
    :layout = '3W',
    :wg_3W = [:nav_blog, list_blog, nil]
  }
end

my_system::page.add do
  :about_me = {
    :layout = '2L',
    :wg_2L = ['nav','about_me']
  }
end

#...

my_system.run! 
#or
my_system.update! 
#or
my_sytem.generate!
```

preview:

Mayby it or not. But i hope code like it.

```ruby
application do
  main {
    name "Simple Blog System"
    title "My Blog"
    layer "3L"
    theme "bootstrap"
  }

  #system admin manage
  admin {
    ip "127.0.0.1"
    weburl "/webAdmin"
    model member,blog
  }

  auth {
    #system root Manager init and not include db.
    root { 
    	name "admin"
    	passwd "admin"
    }

    #member own allow system init
    #ex model
    authUser {
      register true
      owner true
      profile true
      model Rhino::member
      extfield {
      	googlemail mail,true #must
      }      
    }

    setting {

    }
  }

  rule {

  }

  module {
  }

  event {
  }

  plugin {
    modle {
      :category => 'moudle/rcategory'  #category id category->category_id 1->1 field,rule,etc.
    }
  }
  
  page {
  	index do 
  	end

    admin do     
    end

  	blog {
      action ['list','list_category','update','delete','view']
    }

    album {
      action ['list','list_category','update','delete','view']
    }
    
    tag {
      action moudle/rtags # auto find relation model list view & cduv
    }

    category {
    	action moudle/category	
    }

  }

  modle {
    member do {
      model Rhion/member # add all Rhion redefined member fields
      friend moudle/friend # add friend ids
    }
    
    category do {
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
          :label => 'Show Type' ,
          [  
            [:label => 'show by all' , :allow => { true }, :action => '/blog.list~/' ],
            [:label => 'show by own' , :deny => { session.userid != own.userid  }, :action => 'blog.*' ],
            [:label => 'show by firends' , :allow => { session.userid in own.firends }, :action => 'blog.list, blog.view' ]
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
        afterSave { }
        beforeInsert { }
        beforeDelete { }
      }
      setting {
        :albumWidth => [:label => 'album Width', :default => 200]
      }
    end
  }

end
```
