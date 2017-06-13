# frozen_string_literal: true

module Exchange
  class Bank
    require 'open-uri'
    require 'nokogiri'

    attr_reader :market

    def initialize(moment: Time.now.getlocal, document: nil)
      xml = document || fetch(moment)
      hash = {}
      xml.xpath('//Valute').each do |valute|
        hash[valute.elements[1].text.downcase.to_sym] = Currency.new(
          charcode: valute.elements[1].text,
          nominal: valute.elements[2].text,
          name: valute.elements[3].text,
          rate: valute.elements[4].text.sub(/,/, '.')
        )
      end
      @market = Market.new(
        date: xml.xpath('//ValCurs').attribute('Date').value,
        rates: hash
      ).freeze
    end

    private

    def fetch(moment)
      if File.file? filename(moment)
        doc = Nokogiri::XML File.read filename(moment)
      else
        doc = Nokogiri::XML open cb_url(moment)
        File.write write_filename(doc), doc.to_xml
      end
      doc
    end

    def filename(moment)
      "tmp/#{moment.strftime('%d-%m-%Y')}.xml"
    end

    def write_filename(xml)
      "tmp/#{xml.xpath('//ValCurs').attribute('Date').value.sub(/\./, '-')}.xml"
    end

    def cb_url(moment)
      "http://www.cbr.ru/scripts/xml_daily.asp?date_req=#{dotdate(moment)}"
    end

    def dotdate(moment)
      moment.strftime('%d.%m.%Y')
    end
  end
end
