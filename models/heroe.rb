class Heroe < ActiveHash::Base

  ATTRIBUTES_ICONS = {
  	"DOTA_ATTRIBUTE_STRENGTH" => 'attributes/strength.png',
  	"DOTA_ATTRIBUTE_AGILITY" => 'attributes/agility.png',
    "DOTA_ATTRIBUTE_INTELLECT" => 'attributes/intelligence.png'
  }

  HEROES_FILE = File.join(Dota2Pvp.settings.root, Dota2Pvp.settings.heroes_json)

  heroes_in_json = JSON.parse(File.read(HEROES_FILE))["DOTAHeroes"]

  self.data = heroes_in_json.select { |key, value| key != 'Version' }
                            .map do |key, value| 
                              name = key.sub('npc_dota_hero_','')
                              {
                                "BaseName" => key,
                            	"Name" => name,
                            	"image_lg" => "heroes/#{name}_lg.png",
                            	"image_sb" => "heroes/#{name}_sb.png",
                            	"image_vert" => "heroes/#{name}_vert.jpg",
                            	"image_full" => "heroes/#{name}_full.png"
                              }
                              .merge(value)
                            end
  class << self
  	def base
  	  Heroe.all.find_by_name "base"
  	end
  end
end
	