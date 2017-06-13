# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exchange/version'

Gem::Specification.new do |spec|
  spec.name          = 'exchange'
  spec.version       = Exchange::VERSION
  spec.authors       = ['Oleg Sovetnik']
  spec.email         = ['']
  spec.summary       = 'CBRF currency exchange'
  spec.description   = 'CBRF currency exchange'
  spec.homepage      = 'https://github.com/sovetnik/exchange'
  spec.license       = 'MIT'

  spec.add_dependency 'nokogiri'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'pry'
end
