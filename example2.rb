RConfig = Rhino::Config do
  :db {
  }

  :modle {
    :user
  }
end

# Widget contains model forms and etc. (ex: html and javasciprt) 
# it render by templates
RWidget = Rhino::Widget do
  :list_book_title {
    :template # default it's name
    :javascript '' #or :jqueryUI
  }
  :list_relate_book_title {
    :template 'relate_book_title'
  }
end

# View contains one widget and more widgets
# it reander by layer
# it can contains itself
RView = Rhino::View do
  :list_book_name {
      :layer '2W'
      :widgets [
        '1W'=>'list_book_title',
        '2W'=>'list_relate_book_title'
        ]
    }
  :
end

RPage = Rhino::Page do
  :main {
    :layer '3L'
    :layer_1L 'WellCom!'
    :layer_2L Rhino::Widgets::Weather
    :layer_3L Rhino::Widget::Nothing
    :bottom RWidget::View
    :header ''
  }
end

Rpage.add do

end

# it explane one page to other page
RFlow = Rhino::Flow do
  
end

#
REvent = Rhino::Event do
end

RApp = Rhino::Application do 
  :config RConfig
  :widget RWidget
  :container RContainer
  :page RPage
  :event REvent
  :flow RFlow
end

RApp.generate do
  :enableCover true
  :path '.'
end



