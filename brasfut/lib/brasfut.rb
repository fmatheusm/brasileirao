# frozen_string_literal: true

require_relative "brasfut/version"

require "brasfut/entidades/campeonato"
require "brasfut/entidades/equipe"
require "brasfut/entidades/classificacao"
require "brasfut/entidades/partida"
require "brasfut/entidades/rodada"

require 'terminal-table'
require "simplecov"
require "byebug"
SimpleCov.start

module Brasfut
  class Error < StandardError; end

  # Your code goes here...
end
