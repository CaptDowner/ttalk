ymls = ar.yml        devise.en.yml  el.yml  es.yml  i18n-locales.lst  ko.yml  ru.yml
ymls= %w[ar.yml        devise.en.yml  el.yml  es.yml  i18n-locales.lst  ko.yml  ru.yml basei18n.yml  de.yml         en.yml  fr.yml  ja.yml            pt.yml  zh.yml]
ymls.count
ymls
ymls = ymls - %w[i18n-locales.lst]
ymls = ymls.select {|path| path =~ /\.yml/}
ymls << "sdfdsfsdf"
ymls = ymls.select {|path| path =~ /\.yml/}
langs = ymls.select {|fname| fname.split(".")[0] }
langs = ymls.map {|fname| fname.split(".")[0] }
langs = ymls.select {|fname| fname.split(".")[0].length ==2 }
langs = ymls.map {|fname| fname.split(".")[0].length == 2 }
langs = ymls.map {|fname| fname if fname.split(".")[0].length == 2 }
langs = ymls.map {|fname| fname.split(".")[0] }
langs = ymls.select {|fname| fname.split(".")[0].length == 0 }.map {|fname| fname.split(".")[0] }
langs = ymls.select {|fname| fname.split(".")[0].length == 0 }
langs = ymls.select {|fname| fname.split(".")[0].length == 2 }.map {|fname| fname.split(".")[0] }
two_letters_only = ->(array) { array.select {|file| file.split(".").length == 2) }
two_letters_only = ->(array) { array.select {|file| file.split(".").length == 2) }}
two_letters_only = ->(array) { array.select {|file| file.split(".").length == 2 }}
split_on_dot = ->(string) { string.split(".") }
langs_only = ->(array, splitter) { array.map {|file| splitter.call(file)[0] }
langs_only = ->(array, splitter) { array.map {|file| splitter.call(file)[0] }}
ymls= %w[ar.yml        devise.en.yml  el.yml  es.yml  i18n-locales.lst  ko.yml  ru.yml basei18n.yml  de.yml         en.yml  fr.yml  ja.yml            pt.yml  zh.yml]
two_letters_only = ->(array, splitter) { array.select {|file| splitter.(file).length == 2 }}
splitter = split_on_dot
two_letters_only.(ymls, split_on_dot)
two_letters_only = ->(array, splitter) { array.select {|file| splitter.(file)[0].length == 2 }}
two_letters_only.(ymls, split_on_dot)
langs_only.(two_letters_only.(ymls, split_on_dot), split_on_dot)
class AnythingGoes
Object.methods
two_letters_only = ->(array, splitter) { array.select {|file| splitter.(file).length == 2 }}
sh i99vqiiN5mPcL7h9gvkWBwWcy@sf.tmate.io
