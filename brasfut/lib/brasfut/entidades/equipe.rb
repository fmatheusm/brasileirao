class Equipe
  attr_accessor :nome, :sigla, :partidas

  def initialize(nome, sigla)
    self.nome = nome
    self.sigla = sigla
    self.partidas = []
  end

  def classificacao
    pontos = @partidas.map do |partida|
      partida.quantos_pontos_para(self)
    end.sum

    Classificacao.new(self, pontos)
  end

  def vitorias
    partidas.filter do |partida|
      partida.time_vencedor == self
    end.size
  end

  def empates
    partidas.filter do |partida|
      partida.time_vencedor == nil
    end.size
  end

  def derrotas
    partidas.filter do |partida|
      partida.time_vencedor != self
    end.size
  end

  def gols_pro
    return 0 if partidas.empty?

    partidas.map do |partida|
      if partida.mandante == self
        partida.gols_mandante
      else
        partida.gols_visitante
      end
    end.sum
  end

  def gols_contra
    return 0 if partidas.empty?

    partidas.map do |partida|
      if partida.mandante == self
        partida.gols_visitante
      else
        partida.gols_mandante
      end
    end.sum
  end

  def saldo_gols
    gols_pro - gols_contra
  end
end
