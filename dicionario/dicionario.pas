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
    var aux: TNodoChave;
	begin
		if listaI = nil then
			escreva('Lista vazia!')
		else
			begin
                writeln('Do inicio ao fim:');
				aux := listaI;
				while aux <> nil do
					begin
						writeln(aux^.palavra);
						aux := aux^.prox;
					end;
                escreva('Fim da listagem!');

                writeln('Do fim ao comeco:');
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
                            writeln(' - Sem traducoes!')
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

function realocaDicionario(var listaD: TNodoDicionario; pChave: string): TNodoDicionario;
var aux, aux2, aux3: TNodoDicionario;
    bool_while: boolean;
begin
    if listaD = nil then
        realocaDicionario := nil
    else
        begin
            aux := listaD;
            aux2 := nil;
            aux3 := nil;
            bool_while := TRUE;
            while bool_while = TRUE do
                begin
                    //verifica se a tradução é menor que a palavra chave, realocando então o dicionário
                    if aux^.port < pChave then
                        begin
                            if aux3 = nil then
                                aux3 := aux
                            else
                                aux3^.prox := aux;
                        end
                    else
                        begin
                            writeln('Parte do dicionario foi realocado!');
                            aux2^.prox := nil; //limpamos o apontamento do elemento anterior
                            listaD := aux;
                            realocaDicionario := aux3;
                            bool_while := FALSE;
                        end;
                    aux2 := aux; //armazena o anterior para limpar o apontamento posteriormente
                    aux := aux^.prox;
                end;

            if aux3 = nil then
                begin
                    writeln('Nao foi possivel realocar dicionario!');
                    realocaDicionario := nil;
                end
            else if bool_while = TRUE then //Se bool_while = true e a variável não está vazia, significa que todo o dicionário precisa ser realocado
                begin
                    writeln('Todo o dicionario foi realocado!');
                    dispose(listaD);
                    listaD := nil;
                    realocaDicionario := aux3;
                end;
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
                listaF := aux;
            end
        else
            begin
                aux2 := listaI;
                aux3 := nil;
                bool_while := TRUE;
                while bool_while = TRUE do
                    begin
                         if aux2 = nil then //Novo último elemento da lista
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
                                escreva('Palavra chave incluida');
                            end
                        else if p = aux2^.palavra then
                            begin
                                escreva('Palavra chave ja cadastrada!');
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
                                aux^.dicionario := realocaDicionario(aux2^.dicionario, p);
                                aux^.prox := aux2;
                                aux^.ant := aux3;
                                if aux3 = nil then
                                    begin
                                        listaI := aux;
                                        aux2^.ant  := aux;
                                    end
                                else
                                    begin
                                        //insere a nova palavra entre as demais palavras chave
                                        aux3^.prox := aux;
                                        aux2^.ant  := aux
                                    end;
                                bool_while := FALSE;
                                escreva('Palavra chave incluida');
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
                        if aux2 = nil then //Novo último elemento da lista
                            begin
                                aux^.port := tradP;
                                aux^.ing := tradI;
                                aux^.prox := nil;
                                //aponta o prox do elemento anterior para o novo elemento
                                aux3^.prox := aux;
                                bool_while := FALSE;
                            end
                        else if tradP = aux2^.port then
                            begin
                                escreva('Traducao ja cadastrada!');
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
            end;
end;

procedure incluirTraducao(tradP, tradI: string; var listaI, listaF: TNodoChave);
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
                    if tradP = aux^.palavra then
                        begin
                            escreva('A traducao não pode ser igual a palavra chave!');
                            bool_while := FALSE;
                        end
                    else
                        begin
                            //Se a tradução for maior que a última palavra já a incluímos como palavra chave
                            if tradP > listaF^.palavra then
                                begin
                                    incluirPalavraChave(listaI, listaF, tradP);
                                    escreva('A traducao não se encaixa em nenhuma palavra chave, adicionada como palavra chave.');
                                    bool_while := FALSE;
                                end
                            else if tradP > aux^.palavra then
                                begin
                                    aux := aux^.prox;
                                    if aux = nil then
                                        begin
                                            escreva('Nao foi possivel incluir traducao');
                                            bool_while := FALSE;
                                        end;
                                end
                            else
                                begin
                                    incluirPalavra(aux^.dicionario, tradP, tradI);
                                    escreva('Incluido traducao nova!');
                                    bool_while := FALSE;
                                end;
                        end;
                end;
        end;
end;

procedure distribuirDicionario(removido: TNodoChave);
var aux: TNodoDicionario;
    aux2: TNodoChave;
begin
    if removido^.dicionario <> nil then
        begin
            aux := removido^.dicionario;
            aux2 := removido^.prox;
            while aux^.prox <> nil do
                aux := aux^.prox;
            //a última palavra do dicionário da palavra chave sendo removida
            //aponta para o começo do dicionário da próxima palavra chave
            aux^.prox := aux2^.dicionario;
            aux2^.dicionario := removido^.dicionario;
        end
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
                                    escreva('Palavra chave nao encontrada!');
                                    bool_while := FALSE;
                                end;
                        end
                    else if p < aux^.palavra then
                        begin
                            escreva('Palavra chave nao encontrada!');
                            bool_while := FALSE;
                        end
                    else
                        begin
                            if (aux = listaF) and (aux^.dicionario <> nil) then
                                begin
                                    escreva('NNao e possivel remover a ultima palavra chave, pois ela possui dicionario vinculado!');
                                    bool_while := FALSE;
                                end
                            else
                                begin
                                    distribuirDicionario(aux);
                                    if aux = listaI then
                                        begin
                                            listaI := aux^.prox;
                                            aux^.prox^.ant := nil;
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
                                    escreva('A traducao nao se encaixa em nenhuma palavra chave.');
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
                                            escreva('Traducao removida!');
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
                                    escreva('Traducao nao encontrada!');
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
                                    escreva('A traducao nao se encaixa em nenhuma palavra chave.');
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
                                            writeln('Traducao encontrada:');
                                            writeln('Portugues: ', aux2^.port);
                                            writeln('Ingles: ', aux2^.ing);
                                            aux2 := nil;
                                            bool_while := FALSE;
                                        end
                                    else
                                        begin
                                            aux2 := aux2^.prox;
                                        end;
                                end;
                            if bool_while = TRUE then
                                begin
                                    escreva('Traducao nao encontrada!');
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
                    incluirTraducao(port, ing, listaInicio, listaFim);
                end;
                4: begin
                    writeln('Informe a traducao que deseja remover:');
                    readln(port);
                    removerTraducao(port, listaInicio);
                end;
                5: begin
                    writeln('Informe a traducao que deseja consultar:');
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