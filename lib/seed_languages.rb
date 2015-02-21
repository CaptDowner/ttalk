# seed languages and phrases

module SeedLanguages
  extend self

  def seed
    language_abbrvs.each do |abbrv|
      Language.find_or_create_by(abbrv: abbrv).tap do |language|
        phrases_for(abbrv).each do |yml|
          yml[1].each do |k,v|
            phrase = language.phrases.build(key: k, text: v)
            phrase.save
          end
        end
      end
    end
  end
  alias_method :call, :seed

private

  def language_abbrvs
    LanguageConfig.abbrvs
  end

  def phrases_for(lang)
    PhraseConfig.phrases_for(lang)
  end

  module PhraseConfig
    extend self

    def phrases_for(abbrv)
      file = "#{Rails.root}/config/locales/phrases_#{abbrv}.yml"
      YAML.load_file(file)
    end

  end


  module LanguageConfig
    extend self

    def file(lang)
      File.expand_path("#{Rails.root}/config/locales",__FILE__)+"/#{lang}.yml"
    end

    def files
      Dir.glob(File.expand_path("#{Rails.root}/config/locales",__FILE__)+"/*.yml").
              select {|path| path =~ /languages_/}
    end

    def abbrvs
      files.map {|path| path.match(/languages_(\w{2}\-?\w{2}?)/)[1]}
    end
  end

end

