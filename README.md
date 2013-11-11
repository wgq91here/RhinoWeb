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
    category do
      beforeSave { }
      afterSave { }
      beforeInsert { }
      beforeDelete { }
    end
  }
  
  page {
  	index do 
  	end

  	list do
  	end

  	view do
  	end

  	edit do
  	end

  	delete do
  	end

  	update do
  	end

  	admin do     
  	end
  }

  modle {
    blog do
      attrs {
      	title string
      	content text
      	createDate date
      	owner moudle/user #userid
        category moudle/rcategory #category id category->category_id 1->1 field,rule,etc.
      	tags moudle/rtags #auto create tags->blogs *->* field,rule,etc. 
      }
    end

    category do
      attrs {
        title 
      }

  }

end
```