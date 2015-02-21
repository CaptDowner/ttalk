
language_files = -> {
  Dir.glob(File.expand_path("../config/locales",__FILE__)+"/*.yml").
           select {|path| path =~ /languages_/}
}
languages = ->(finder_func) {
  finder_func.call.map {|path| path.match(/languages_(\w{2}\-?\w{2}?)/)[1]}
}

puts languages.(language_files)

