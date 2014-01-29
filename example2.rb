RConfig = Rhino::Config do
  :db {
  }

  :modle {
    :user
  }
end

# Widget contains model forms and etc. (ex: html and javasciprt) 
RWidget = Rhino::Widget do

end

# View contains one widget and more widgets
RView = Rhino::View do
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

RFlow = Rhino::Flow do
  
end

RApp = Rhino::Application do 
  :config RConfig
  :widget RWidget
  :container RContainer
  :page RPage
  :flow RFlow
end

RApp.generate do
  :enableCover true
  :path '.'
end



