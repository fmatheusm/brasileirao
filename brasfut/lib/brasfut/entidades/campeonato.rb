class Campeonato
  attr_accessor :edicao, :equipes, :rodadas

  def initialize(edicao)
    @edicao = edicao
    @equipes = []
    @rodadas = []
  end

  def classificacao
    @equipes.map do |equipe|
      equipe.classificacao
    end.sort { |x, y| y.pontos <=> x.pontos }
  end

  def criar_tabela!
    tabela = ''
    mandante_visitante = []
    numero_da_rodada = []
    @rodadas.each do |rodada|
      tabela += "RODADA #{rodada.numero}\n"
      tabela +=  "----------------------\n"

      scala_jogos.map do |jogo|

        tabela += "#{jogo[0]} X #{jogo[1]}\n"
      end

      tabela += "\n"
    end

    tabela

    ## Implementar a geracao automatica da tabela
    ## considerando que todos os times devem
    ## jogar entre sí em turno e returno
    ## uma vez como mandante e outra como visitante
  end


  def scala_jogos
    jogos = []
    (0...@equipes.length).each do |i|
      (i+1...@equipes.length).each do |j|
        jogos.push([equipes[i].sigla, equipes[j].sigla])
        jogos.push([equipes[j].sigla, equipes[i].sigla])
      end
    end
    return jogos
  end

  def imprimir_tabela
    puts criar_tabela!

    ## Implementar um metodo que retorne uma string
    ## representando a tabela de jogos no seguinte formato
    ## RODADA <numero da rodada>
    ## ------------------------
    ## CAM X CRU
    ## VAS X FOR
    ##
    ## RODADA <numero da rodada>
    ## ------------------------
    ## CAM X CRU
    ## VAS X FOR
  end

  def imprimir_classificao
    ## Implementar um metodo que retorno uma string
    ## representando a classificacao dos times no seguinte formato
    ## | # | Sigla | Time        | Pontos | Vitorias | Empates | Derrotas | Saldo de Gols | Gols Pro | Gols Contra |
    ## |---|-------|-------------|--------|----------|---------|----------|---------------|----------|-------------|
    ## | 1 | CAM   | Atletico-MG | 18     | 3        | 1       | 0        | 20            | 22       | 2           |
    ## | 2 | VAS   | Vasco       | 12     | 1        | 3       | 2        | -4            | 4        | 8           |
    ## Modifique o projeto para ter as informações necessárias para a geração da tabela

    rows = classificacao.map.with_index do |record, index| 
      equipe = record.equipe
      [
        index + 1, equipe.sigla, equipe.nome, record.pontos, 
        equipe.vitorias, equipe.empates, equipe.derrotas,
        equipe.saldo_gols, equipe.gols_pro, equipe.gols_contra
      ]
    end

    table = Terminal::Table.new do |t|
      t.headings = ['#', 'Sigla', 'Time', 'Pontos', 'Vitorias', 'Empates', 'Derrotas', 'Saldo de Gols', 'Gols Pro', 'Gols Contra']
      t.rows = rows
      t.style = { border_top: false, border_bottom: false, border_i: "|" }
    end

    table
  end

end
