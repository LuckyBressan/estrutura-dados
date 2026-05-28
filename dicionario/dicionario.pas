Program dicionario_atividade;

uses crt;

type
    TNodoDicionario = ^TDicionario;
    TDicionario = record
        port: string;
        ing: string;
        prox: TNodoDicionario
    end;
    TNodoChave = ^TPalavraChave;
    TPalavraChave = record
        ant : TNodoChave;
        palavra: string;
        dicionario: TNodoDicionario;
        prox : TNodoChave
    end;

var listaInicio, listaFim: TNodoChave;
    chave, port, ing: string;
    op: integer;


procedure escreva(m: string);
    begin
        writeln();
        writeln();
        writeln(m);
        writeln();
        writeln();
    end;

procedure escrevePalavraChave(listaI, listaF: TNodoChave);
    var aux : TNodoChave;
		pos : integer;
	begin
		if listaI = nil then
			escreva('Lista vazia!')
		else
			begin
                writeln('Do início ao fim:');
				aux := listaI;
				while aux <> nil do
					begin
						writeln(aux^.palavra);
						aux := aux^.prox;
					end;
                escreva('Fim da listagem!');

                writeln('Do fim ao começo:');
                aux := listaF;
				while aux <> nil do
					begin
						writeln(aux^.palavra);
						aux := aux^.ant;
					end;
                escreva('Fim da listagem!');
			end;
	end;

procedure escreveDicionario(listaI: TNodoChave);
    var aux : TNodoChave;
        aux2: TNodoDicionario;
    begin
        if listaI = nil then
            escreva('Lista vazia!')
        else
            begin
                aux := listaI;
                while aux <> nil do
                    begin
                        writeln('Palavra Chave: ', aux^.palavra);
                        aux2 := aux^.dicionario;
                        if aux2 = nil then
                            writeln(' - Sem traduções!')
                        else
                        while aux2 <> nil do
                            begin
                                writeln(' - ', aux2^.port, ' -> ', aux2^.ing);
                                aux2 := aux2^.prox;
                            end;
                        writeln();
                        aux := aux^.prox;
                    end;
                escreva('Fim da listagem!');
            end;
    end;

procedure iniciarLista(var lista: TNodoChave);
begin
    lista := nil;
end;

procedure incluirPalavraChave(var listaI, listaF: TNodoChave; p: string);
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
        if listaI = nil then
            begin
                aux^.ant := nil;
                aux^.palavra := p;
                aux^.dicionario := nil;
                aux^.prox := nil;
                listaI := aux;
            end
        else
            begin
                aux2 := listaI;
                aux3 := nil;
                bool_while := TRUE;
                while bool_while = TRUE do
                    begin
                        if (aux2 <> nil) and (p = aux2^.palavra) then
                            begin
                                escreva('Palavra chave ja cadastrada!');
                                bool_while := FALSE;
                            end
                        else if aux2 = nil then //Novo último elemento da lista
                            begin
                                aux^.palavra := p;
                                aux^.dicionario := nil;
                                aux^.prox := nil;
                                //aponta o ant do elemento novo para o elemento anterior
                                aux^.ant  := aux3;
                                //aponta o prox do elemento anterior para o novo elemento
                                aux3^.prox := aux;

                                //Armazena o final da lista
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
                                aux^.ant := aux3;
                                if aux3 = nil then
                                    listaI := aux
                                else
                                    begin
                                        //insere a nova palavra entre as demais palavras chave
                                        aux3^.prox := aux;
                                        aux2^.ant  := aux
                                    end;
                                bool_while := FALSE;
                            end;
                    end;
            end;
end;

procedure incluirPalavra(var listaD: TNodoDicionario; tradP, tradI: string);
var aux, aux2, aux3: TNodoDicionario;
    bool_while: boolean;
begin
    new(aux);
    if aux = nil then
        begin
            escreva('Sem memoria!');
            readkey
        end
    else
        if listaD = nil then
            begin
                aux^.port := tradP;
                aux^.ing := tradI;
                aux^.prox := nil;
                listaD := aux;
            end
        else
            begin
                aux2 := listaD;
                aux3 := nil;
                bool_while := TRUE;
                while bool_while = TRUE do
                    begin
                        if tradP = aux2^.port then
                            begin
                                escreva('Tradução ja cadastrada!');
                                bool_while := FALSE;
                            end
                        else if aux2 = nil then //Novo último elemento da lista
                            begin
                                aux^.port := tradP;
                                aux^.ing := tradI;
                                aux^.prox := nil;
                                //aponta o prox do elemento anterior para o novo elemento
                                aux3^.prox := aux;
                                bool_while := FALSE;
                            end
                        else if tradP > aux2^.port then
                            begin
                                aux3 := aux2;
                                aux2 := aux2^.prox;
                            end
                        else if tradP < aux2^.port then
                            begin
                                aux^.port := tradP;
                                aux^.ing := tradI;
                                aux^.prox := aux2;
                                if aux3 = nil then
                                    listaD := aux
                                else
                                    //insere a nova palavra entre as demais palavras chave
                                    aux3^.prox := aux;
                                bool_while := FALSE;
                            end;
                    end;
                escreva('Palavra chave salva!');
            end;
end;

procedure incluirTraducao(tradP, tradI: string; var listaI: TNodoChave);
var aux: TNodoChave;
bool_while: boolean;
begin
    if listaI = nil then
        escreva('Sem palavras chave!')
    else
        begin
            aux := listaI;
            bool_while := TRUE;
            while bool_while = TRUE do
                begin
                    if tradP > aux^.palavra then
                        begin
                            aux := aux^.prox;
                            if aux = nil then
                                begin
                                    escreva('A tradução não se encaixa em nenhuma palavra chave.');
                                    bool_while := FALSE;
                                end;
                        end
                    else
                        begin
                            incluirPalavra(aux^.dicionario, tradP, tradI);
                            escreva('Incluído tradução nova!');
                            bool_while := FALSE;
                        end;
                end;
        end;
end;



procedure removerPalavraChave(var listaI, listaF: TNodoChave; p: string);
var aux: TNodoChave;
    bool_while: boolean;
begin
    if listaI = nil then
        escreva('Sem palavras chave!')
    else
        begin
            aux := listaI;
            bool_while := TRUE;
            while bool_while = TRUE do
                begin
                    if p > aux^.palavra then
                        begin
                            aux := aux^.prox;
                            if aux = nil then
                                begin
                                    escreva('Palavra chave não encontrada!');
                                    bool_while := FALSE;
                                end;
                        end
                    else if p < aux^.palavra then
                        begin
                            escreva('Palavra chave não encontrada!');
                            bool_while := FALSE;
                        end
                    else
                        begin
                            if aux = listaI then
                                begin
                                    listaI := aux^.prox;
                                    if aux^.prox <> nil then
                                        aux^.prox^.ant := nil;
                                end
                            else if aux = listaF then
                                begin
                                    listaF := aux^.ant;
                                    if aux^.ant <> nil then
                                        aux^.ant^.prox := nil;
                                end
                            else
                                begin
                                    aux^.ant^.prox := aux^.prox;
                                    aux^.prox^.ant := aux^.ant;
                                end;
                            dispose(aux);
                            escreva('Palavra chave removida!');
                            bool_while := FALSE;
                        end;
                end;
        end;
end;

procedure removerTraducao(tradP: string; var listaI: TNodoChave);
var aux: TNodoChave;
    aux2, aux3: TNodoDicionario;
    bool_while: boolean;
begin
    if listaI = nil then
        escreva('Sem palavras chave!')
    else
        begin
            aux := listaI;
            bool_while := TRUE;
            while bool_while = TRUE do
                begin
                    if tradP > aux^.palavra then
                        begin
                            aux := aux^.prox;
                            if aux = nil then
                                begin
                                    escreva('A tradução não se encaixa em nenhuma palavra chave.');
                                    bool_while := FALSE;
                                end;
                        end
                    else
                        begin
                            aux2 := aux^.dicionario;
                            aux3 := nil;
                            while aux2 <> nil do
                                begin
                                    if tradP = aux2^.port then
                                        begin
                                            if aux3 = nil then
                                                aux^.dicionario := aux2^.prox
                                            else
                                                aux3^.prox := aux2^.prox;
                                            dispose(aux2);
                                            escreva('Tradução removida!');
                                            bool_while := FALSE;
                                        end
                                    else                                        
                                        begin
                                            aux3 := aux2;
                                            aux2 := aux2^.prox;
                                        end;
                                end;
                            if bool_while = TRUE then
                                begin
                                    escreva('Tradução não encontrada!');
                                    bool_while := FALSE;
                                end;
                        end;
                end;
        end;
end;

procedure consultaTraducao(tradP: string; var listaI: TNodoChave);
var aux: TNodoChave;
    aux2: TNodoDicionario;
    bool_while: boolean;
begin
    if listaI = nil then
        escreva('Sem palavras chave!')
    else
        begin
            aux := listaI;
            bool_while := TRUE;
            while bool_while = TRUE do
                begin
                    if tradP > aux^.palavra then
                        begin
                            aux := aux^.prox;
                            if aux = nil then
                                begin
                                    escreva('A tradução não se encaixa em nenhuma palavra chave.');
                                    bool_while := FALSE;
                                end;
                        end
                    else
                        begin
                            aux2 := aux^.dicionario;
                            while aux2 <> nil do
                                begin
                                    if tradP = aux2^.port then
                                        begin
                                            writeln('Tradução encontrada:');
                                            writeln('Português: ', aux2^.port);
                                            writeln('Inglês: ', aux2^.ing);
                                            bool_while := FALSE;
                                        end
                                    else                                        
                                        begin
                                            aux2 := aux2^.prox;
                                        end;
                                end;
                            if bool_while = TRUE then
                                begin
                                    escreva('Tradução não encontrada!');
                                    bool_while := FALSE;
                                end;
                        end;
                end;
        end;
end;

Begin

    op := 1;
    iniciarLista(listaInicio);
    iniciarLista(listaFim);

    while op <> 0 do
        begin
            writeln('0 - Sair');
            writeln('1 - Cadastrar palavra chave');
            writeln('2 - Remover palavra chave');
            writeln('3 - Incluir traducao');
            writeln('4 - Remover traducao');
            writeln('5 - Consultar dicionario');
            writeln('6 - Escrever dicionario');
            writeln('7 - Escrever palavras-chave');

            writeln();
            writeln();
			readln(op);
			writeln();
            writeln();

            case op of
                1: begin
                    writeln('Informe a palavra chave:');
                    readln(chave);
                    incluirPalavraChave(listaInicio, listaFim, chave);
                end;
                2: begin
                    writeln('Informe a palavra chave que deseja remover:');
                    readln(chave);
                    removerPalavraChave(listaInicio, listaFim, chave);
                end;
                3: begin
                    writeln('Informe a palavra em portugues:');
                    readln(port);
                    writeln('Informe a traducao em ingles:');
                    readln(ing);
                    incluirTraducao(port, ing, listaInicio);
                end;
                4: begin
                    writeln('Informe a tradução que deseja remover:');
                    readln(port);
                    removerTraducao(port, listaInicio);
                end;
                5: begin
                    writeln('Informe a tradução que deseja consultar:');
                    readln(port);
                    consultaTraducao(port, listaInicio);
                end;
                6: begin
                    writeln('Essas sao as palavras chave e suas traducoes:');
                    escreveDicionario(listaInicio);
                end;
                7: begin
                    writeln('Essas sao as palavras chave:');
                    escrevePalavraChave(listaInicio, listaFim);
                end;
            end;
        end;

End.