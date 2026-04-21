program atividade_truco;

uses crt, sysutils;

type
  // Naipes: 1=Ouros, 2=Espadas, 3=Copas, 4=Paus (Ordem de força das manilhas)
  TCarta = record
    valor: integer;
    naipe: integer;
    peso: integer;
    nomeNaipe: string;
  end;

  PElemento = ^TElemento;
  TElemento = record
    carta: TCarta;
    proximo: PElemento;
  end;

  TPilha = record topo: PElemento; end;
  TFila  = record inicio, fim: PElemento; end;
  TLista = record primeiro: PElemento; end;

var
  baralhoPilha: TPilha;
  mesaFila: TFila;
  maoJogador, maoCPU: TLista;
  vira: TCarta;
  pontosJogador, pontosCPU: integer;
  valorMao: integer;


// ESTRUTURA DE DADOS - FUNÇÕES AUXILIARES

procedure iniciaPilha(var pilha: TPilha);
begin
    pilha.topo := nil;
end;

procedure iniciaFila(var fila: TFila);
begin
    fila.inicio := nil;
    fila.fim := nil;
end;
procedure iniciaLista(var lista: TLista);
begin
    lista.primeiro := nil;
end;

// PILHA - melhor usar nomes de métodos JS
procedure push(var pilha: TPilha; carta: TCarta);
var novo: PElemento;
begin
  new(novo);
  novo^.carta := carta;
  novo^.proximo := pilha.topo;
  pilha.topo := novo;
end;

function pop(var pilha: TPilha): TCarta;
var aux: PElemento;
begin
    aux := pilha.topo;
    pop := aux^.carta;
    pilha.topo := aux^.proximo;
    dispose(aux);
end;

function pilhaVazia(pilha: TPilha): boolean;
begin
    pilhaVazia := (pilha.topo = nil);
end;

// FILA
procedure enfileirar(var fila: TFila; carta: TCarta);
var novo: PElemento;
begin
    new(novo);
    novo^.carta := carta;
    novo^.proximo := nil;
    if fila.inicio = nil then
        fila.inicio := novo
    else
        fila.fim^.proximo := novo;
    fila.fim := novo;
end;

function tirarFila(var fila: TFila): TCarta;
var aux: PElemento;
begin
    aux := fila.inicio;
    tirarFila := aux^.carta;
    fila.inicio := aux^.proximo;
    if fila.inicio = nil then
        fila.fim := nil;
    dispose(aux);
end;

// LISTA
procedure inserirLista(var lista: TLista; carta: TCarta);
var novo: PElemento;
begin
    new(novo);
    novo^.carta := carta;
    novo^.proximo := lista.primeiro;
    lista.primeiro := novo;
end;

// Remove uma carta específica da mão do jogador (1, 2 ou 3)
function removerLista(var lista: TLista; posicao: integer): TCarta;
var aux, ant: PElemento; i: integer;
begin
  aux := lista.primeiro;
  ant := nil;
  i   := 1;
  while (aux <> nil) and (i < posicao) do begin
    ant := aux;
    aux := aux^.proximo;
    i := i + 1;
  end;
  if aux <> nil then begin
    removerLista := aux^.carta;
    if ant = nil then
        lista.primeiro := aux^.proximo
    else
        ant^.proximo := aux^.proximo;
    dispose(aux);
  end;
end;

{ ==================================================================== }
{ LÓGICA DO JOGO E REGRAS DO TRUCO                                     }
{ ==================================================================== }

// Define a força base da carta (4 é a mais fraca, 3 a mais forte)
// acho que nunca vou entender essa lógica...
function pesoBase(valor: integer): integer;
begin
  case valor of
    4: pesoBase := 1;
    5: pesoBase := 2;
    6: pesoBase := 3;
    7: pesoBase := 4;
    10: pesoBase := 5;
    11: pesoBase := 6;
    12: pesoBase := 7;
    1: pesoBase := 8;
    2: pesoBase := 9;
    3: pesoBase := 10;
  end;
end;

// Atualiza o peso das cartas nas mãos baseado no Vira (Manilhas)
procedure atualizarPesos(var lista: TLista; viraValor: integer);
var
  aux: PElemento;
  valorManilha: integer;
begin
  // Descobre qual é a manilha (a próxima carta depois do vira)
  case viraValor of
    7: valorManilha := 10;
    12: valorManilha := 1;
    3: valorManilha := 4;
    else valorManilha := viraValor + 1;
  end;

  aux := lista.primeiro;
  //vamo de carta em carta atualizando o peso
  while aux <> nil do
    begin
        if aux^.carta.valor = valorManilha then
            // Se for manilha, o peso é alto (10 base + naipe) -> 11 a 14
            aux^.carta.peso := 10 + aux^.carta.naipe
        else
            aux^.carta.peso := pesoBase(aux^.carta.valor);
        aux := aux^.proximo;
    end;
end;

// Cria, embaralha (em vetor para facilitar minha vida) e joga na Pilha
procedure prepararBaralho(var pilha: TPilha);
var
  vet: array[1..40] of TCarta;
  i, j, posAleatoria: integer;
  cAux: TCarta;
  nomes: array[1..4] of string;
begin
  iniciaPilha(pilha);
  nomes[1] := 'Ouros'; nomes[2] := 'Espadas'; nomes[3] := 'Copas'; nomes[4] := 'Paus';
  i := 1;
  for j := 1 to 4 do
    for posAleatoria := 1 to 12 do
      if not (posAleatoria in [8, 9]) then //truco não tem as cartas 8 e 9
        begin
            vet[i].valor := posAleatoria; //valor da carta 1 -> 12
            vet[i].naipe := j; // "código" do naipe
            vet[i].nomeNaipe := nomes[j]; // nome do naipa para exibição durante jogo
            i := i + 1;
        end;

  // Embaralha
  for i := 40 downto 2 do begin
    posAleatoria := random(i) + 1;
    cAux := vet[i]; //armazenamos como estava antes
    vet[i] := vet[posAleatoria]; //colocamos outro aleatório no lugar
    vet[posAleatoria] := cAux; //o que era aleatório se torna o valor que armazenamos
  end;

  //armazenamos na pilha
  for i := 1 to 40 do
    push(pilha, vet[i]);
end;

// "O baralho deve ser cortado e as cartas distribuídas usando princípio de fila"
procedure cortaBaralho(var pilha: TPilha; var fila: TFila);
begin
  iniciaFila(fila);
  while not pilhaVazia(pilha) do
    enfileirar(fila, pop(pilha));
end;

// Imprime a carta de forma "amigável", mostrando o nome do naipe e o valor, ao invés de só números
procedure mostrarCarta(carta: TCarta);
begin
  write('[ ', carta.valor, ' de ', carta.nomeNaipe, ' ]');
end;

procedure mostrarMao(lista: TLista);
var aux: PElemento; i: integer;
begin
  aux := lista.primeiro;
  i := 1;
  while aux <> nil do
    begin
        write(i, ': ');
        mostrarCarta(aux^.carta);
        write('   ');
        aux := aux^.proximo;
        i := i + 1;
    end;
  writeln;
end;


// AQUI FICA O JOGO PRINCIPAL

procedure jogarMao;
var
  i, rodada, vitoriasJog, vitoriasCPU: integer;
  cartaJog, cartaCPU: TCarta;
  opcao: integer;
begin
  valorMao := 1; vitoriasJog := 0; vitoriasCPU := 0;

  prepararBaralho(baralhoPilha);
  cortaBaralho(baralhoPilha, mesaFila);

  iniciaLista(maoJogador);
  iniciaLista(maoCPU);

  // 3) Distribui 3 cartas para as Listas dos jogadores
  for i := 1 to 3 do begin
    inserirLista(maoJogador, tirarFila(mesaFila));
    inserirLista(maoCPU, tirarFila(mesaFila));
  end;

  vira := tirarFila(mesaFila); // A próxima da fila é a carta que determina a manilha, apelido = vira

  atualizarPesos(maoJogador, vira.valor);
  atualizarPesos(maoCPU, vira.valor);

  writeln('--------------------------------------------------');
  write('VIRA DA RODADA: '); mostrarCarta(vira); writeln;
  writeln('--------------------------------------------------');

  // Melhor de 3 rodadas
  for rodada := 1 to 3 do
    begin
        writeln('--- Rodada ', rodada, ' ---');
        writeln('Sua mao:');
        mostrarMao(maoJogador);

        write('Escolha qual carta jogar (1, 2 ou 3) ou digite 9 para pedir TRUCO: ');
        readln(opcao);

        if opcao = 9 then
            begin
                writeln('VOCE PEDIU TRUCO!');
                //50% de chance de aceitar (quando eu quero que aceite ela não aceita... esperta)
                if random(2) = 1 then
                    begin
                        writeln('CPU: Eu ACEITO!'); //ela não sabe que eu blefo
                        if valorMao < 3 then
                            valorMao := 3
                        else if valorMao < 12 then
                            valorMao := valorMao + 3; // incrementa de 3 em 3, conforme for pedindo truco
                        write('Escolha a carta (1, 2 ou 3): '); readln(opcao);
                    end
                else
                    begin
                        writeln('CPU: Eu CORRO!'); // covarde
                        vitoriasJog := 2;
                    end;
            end;

        if vitoriasJog < 2 then //caso a CPU corra do truco, o jogador já vence a mão, então não precisa jogar
            begin
                cartaJog := removerLista(maoJogador, opcao);
                cartaCPU := removerLista(maoCPU, 1); // CPU joga sempre a primeira para simplificar

                write('Voce jogou: ');
                mostrarCarta(cartaJog);
                writeln;

                write('CPU jogou : ');
                mostrarCarta(cartaCPU);
                writeln;

                if cartaJog.peso > cartaCPU.peso then
                    begin
                        writeln('=> Voce venceu a rodada!');
                        vitoriasJog := vitoriasJog + 1;
                    end
                else if cartaCPU.peso > cartaJog.peso then
                    begin
                        writeln('=> CPU venceu a rodada!');
                        vitoriasCPU := vitoriasCPU + 1;
                    end
                else
                    begin
                        writeln('=> Empate (Empachou)!'); //nem sei se é assim que se escreve
                        vitoriasJog := vitoriasJog + 1;
                        vitoriasCPU := vitoriasCPU + 1;
                    end;
                writeln;
            end;

        if vitoriasJog >= 2 then
            begin
                writeln('*** VOCE VENCEU A MAO! GANHOU ', valorMao, ' PONTOS. ***');
                pontosJogador := pontosJogador + valorMao;
                break;
            end
        else if vitoriasCPU >= 2 then
            begin
                writeln('*** CPU VENCEU A MAO! GANHOU ', valorMao, ' PONTOS. ***');
                pontosCPU := pontosCPU + valorMao;
                break;
            end;
    end;
end;


begin
  Randomize;
  pontosJogador := 0; pontosCPU := 0;

  writeln('==================================================');
  writeln('            TRUCO PASCAL - ESTRUTURA DE DADOS     ');
  writeln('==================================================');

  while (pontosJogador < 12) and (pontosCPU < 12) do begin
    writeln;
    writeln('PLACAR GERAL -> Voce: ', pontosJogador, ' | CPU: ', pontosCPU);
    writeln('Pressione ENTER para dar as cartas...');
    readln;
    jogarMao();
  end;

  writeln('==================================================');
  if pontosJogador >= 12 then writeln('PARABENS! VOCE VENCEU O JOGO!')
  else writeln('QUE PENA! A CPU VENCEU O JOGO! (bobao)');
  writeln('==================================================');
  readln;
end.