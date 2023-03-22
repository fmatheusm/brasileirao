# frozen_string_literal: true

require "brasfut"

RSpec.describe Brasfut do
  before(:all) do
    @campeonato = Campeonato.new(2023)
    @cam = Equipe.new("Atlético-MG", "CAM")
    @vas = Equipe.new("Vasco", "VAS")
    @cru = Equipe.new("Cruzeiro", "CRU")
    @fort = Equipe.new("Fortaleza", "FOR")
    @campeonato.equipes = [@vas, @cam, @cru, @fort]
  end

  it "Todos os times devem ter zero pontos" do
    @campeonato.equipes.each do |equipe|
      expect(equipe.classificacao.pontos).to eq(0)
    end
  end

  it "Deve calcular 3 pontos por uma vitoria" do
    @vas.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cam, @vas)
    partida.gols_mandante = 2
    partida.gols_visitante = 1

    expect(@cam.classificacao.pontos).to eq(3)
    expect(@vas.classificacao.pontos).to eq(0)
  end

  it "Deve calcular 1 ponto por empate" do
    @vas.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cam, @vas)
    partida.gols_mandante = 5
    partida.gols_visitante = 5

    expect(@cam.classificacao.pontos).to eq(1)
    expect(@vas.classificacao.pontos).to eq(1)
  end

  it "Deve calcular 0 ponto por derrota" do
    @vas.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cru, @cam)
    partida.gols_mandante = 0
    partida.gols_visitante = 1

    expect(@cru.classificacao.pontos).to eq(0)
    expect(@cam.classificacao.pontos).to eq(3)
  end

  it "O galo deve estar em primeiro e o vasco em segundo" do
    @vas.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cam, @vas)
    partida.gols_mandante = 2
    partida.gols_visitante = 1

    classificacoes = @campeonato.classificacao
    expect(classificacoes[0].equipe).to eq(@cam)
    expect(classificacoes[0].pontos).to eq(3)

    expect(classificacoes[1].equipe).to eq(@vas)
    expect(classificacoes[1].pontos).to eq(0)
  end

  it "Devo ter uma tablema que mostre a rodada e os jogos" do
    @vas.partidas = []
    @cam.partidas = []
    @cru.partidas = []

    rodada_1 = Rodada.new(1)
    cam_x_vas = Partida.new(@cam, @vas)
    cam_x_vas.gols_mandante = 3
    cam_x_vas.gols_visitante = 1

    cru_x_fort = Partida.new(@cru, @fort)
    cru_x_fort.gols_mandante = 3
    cru_x_fort.gols_visitante = 4
    rodada_1.partidas = [cam_x_vas, cru_x_fort]
    @campeonato.rodadas << rodada_1

    rodada_2 = Rodada.new(2)
    vas_x_cam = Partida.new(@vas, @cam)
    vas_x_cam.gols_mandante = 1
    vas_x_cam.gols_visitante = 2

    fort_x_cur = Partida.new(@fort, @cru)
    fort_x_cur.gols_mandante = 3
    fort_x_cur.gols_visitante = 4
    rodada_2.partidas = [vas_x_cam, fort_x_cur]
    @campeonato.rodadas << rodada_2

    expect(@campeonato.criar_tabela!.class).to eq(String)
  end


  it 'deve imprimir a tabela' do
    expect(@campeonato.criar_tabela!).to include("RODADA 1\n----------------------\nVAS X CAM")
  end

  it 'devo ter uma classificac ãoclassificacao' do
    expect(@campeonato.imprimir_classificao.class).to eq(Terminal::Table)
  end

end
