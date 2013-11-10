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
    layerCss "bootstrap"
  }

  access {
    #system root Manager init and not include db.
    root { 
    	name "admin"
    	passwd "admin"
    }

    #member own allow system init
    #ex model
    member {
      lable 'user manager'
      register true
      owner true
      profile true
      extfield {
      	googlemail mail,true #must
      }      
    }

    #system manage
    admin {
		weburl "/admin"
		manageModel member,blog
		ip "127.0.0.1"
    }

  }
  
  rule {

  }

  module {

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
      	tags moudle/tags #auto create tags->blogs *->* field,rule,etc. 
      }      
    end
end
```