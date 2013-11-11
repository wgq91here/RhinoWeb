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
      model "member"
      extfield {
      	googlemail mail,true #must
      }      
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
      category moudle/rcategory  #category id category->category_id 1->1 field,rule,etc.
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

  }

  modle {
    blog do
      attrs {
      	title string
      	content text
      	createDate date
      	owner moudle/user #userid
        category plugin/category #use module category
      	tags moudle/rtags #auto create tags->blogs *->* field,rule,etc. 
      }
      event {
        beforeSave do 
          time()
        end
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
    end    
  }

end
```