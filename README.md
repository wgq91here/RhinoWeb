RhinoWeb
========

RhinoWeb

Use by Ruby create a web application auto.

## Features

## Usage

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
