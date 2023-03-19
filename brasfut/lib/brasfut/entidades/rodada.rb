class Rodada
  attr_accessor :numero, :partidas

  def initialize(numero)
    @numero = numero
    @partidas = []
  end
end