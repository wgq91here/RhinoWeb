my_system = Rhino::Application.new

my_system::config {
  db = []
}


my_system::config.add {
  name = 'My System'
}

my_system::auth {
  enable = true,
      user = {:ext_fields => ['int:age:scope(1..2)']}
}
