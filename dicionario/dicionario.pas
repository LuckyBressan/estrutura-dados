Program dicionario_atividade;

uses crt;

type
    TNodoChave = ^TPalavraChave;
    TPalavraChave = record
        ant : TNodoChave;
        palavra: string;
        dicionario: TNodoDicionario
        prox : TNodoChave
    end;
    TNodoDicionario = ^TDicionario;
    TDicionario = record
        port: string;
        ing: string;
        prox: TNodoDicionario
    end;

var listaChave, listaInicio, listaFim: TNodoChave;
    chave: string;
    op: integer;


procedure escreva(m: string);
    begin
        writeln();
        writeln();
        writeln(m);
        writeln();
        writeln();
    end;

{ PARTE RELACIONADA A PALAVRA CHAVE }

procedure iniciarListaChave(var listaC: TNodoChave);
begin
    listaC := nil;
end;

procedure incluirPalavraChave(var listaC, listaI, listaF: TNodoChave; p: string);
var aux, aux2, aux3: TNodoChave;
    bool_while: boolean;
begin
    new(aux);
    if aux = nil then
        begin
            escreva('Sem memoria!');
            readkey
        end
    else
        if listaC = nil then
            begin
                aux^.ant := nil;
                aux^.palavra := p;
                aux^.dicionario := nil;
                aux^.prox := nil;
                listaC := aux;
            end
        else
            begin
                aux2 := listaC;
                aux3 := nil;
                bool_while := TRUE;
                while bool_while = TRUE do
                    begin
                        if p = aux2^.palavra then
                            begin
                                escreva('Palavra chave ja cadastrada!');
                                bool_while := FALSE;
                            end
                        else if aux2 = nil then
                            begin
                                aux^.palavra := p;
                                aux^.dicionario := nil;
                                aux^.prox := nil;
                                //aponta o ant do elemento novo para o elemento anterior
                                aux^.ant  := aux3;
                                //aponta o prox do elemento anterior para o novo elemento
                                aux3^.prox := aux;
                                listaF := aux;
                                bool_while := FALSE;
                            end
                        else if p > aux2^.palavra then
                            begin
                                aux3 := aux2;
                                aux2 := aux2^.prox;
                            end
                        else if p < aux2^.palavra then
                            begin
                                aux^.palavra := p;
                                aux^.dicionario := nil;
                                aux^.prox := aux2;
                                aux^.ant := nil;
                                if aux3 = nil then
                                    listaC := aux
                                else
                                    begin
                                        aux3^.prox := aux;
                                        aux^.ant := aux3
                                    end;
                                bool_while := FALSE;
                            end;
                    end
                listaI := listaC
            end
end;

procedure escrevePalavraChave(listaC: TNodoChave);
    var aux : TNodoChave;
		pos : integer;
	begin
		if listaC = nil then
			escreva('Lista vazia!')
		else
			begin
				aux := listaC;
				while aux <> nil do
					begin
						writeln(aux^.palavra);
						aux := aux^.prox;
					end;
                escreva('Fim da lista!')
			end;
	end;

Begin

    op := 1;
    iniciarListaChave(listaChave);

    while op <> 0 do
        begin
            writeln('0 - Sair');
            writeln('1 - Cadastrar palavra chave');
            writeln('2 - Incluir traducao');
            writeln('3 - Remover traducao');
            writeln('4 - Consultar dicionario');
            writeln('5 - Escrever dicionario');
            writeln('6 - Escrever palavras-chave');

            writeln();
            writeln();
			readln(op);
			writeln();
            writeln();

            case op of
                1: begin
                    writeln('Informe a palavra chave:');
                    readln(chave);
                    incluirPalavraChave(listaChave, chave);
                    escreva('Palavra chave salva!');
                end;
                2: begin
                end;
                3: begin
                end;
                4: begin
                end;
                5: begin
                end;
                6: begin
                    writeln('Essas sao as palavras chave:');
                    escrevePalavraChave(listaChave);
                end;
            end;
        end;

End.