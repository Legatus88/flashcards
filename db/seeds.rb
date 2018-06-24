# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rubygems'
require 'nokogiri'
require 'rexml/document'
include REXML

page = Nokogiri::HTML(open("http://1000mostcommonwords.com/1000-most-common-german-words/")).at('div.entry-content')
tds = page.xpath('//td')
couples = tds.reject(&:first).select { |td| td.text.to_i.eql? 0 }.map(&:text).each_slice(2).to_a
couples.each do |d_word, e_word|
  Card.create(original_text: "#{d_word}", translated_text: "#{e_word}", review_date: Date.today)
end
