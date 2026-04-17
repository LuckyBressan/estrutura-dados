Program ponteiro_lista;

uses crt;

type
	type_default = integer;
	ptnodo = ^elemento;
	elemento = record
		dado : type_default;
		prox : ptnodo
	end;

var n: type_default;
    op: byte;
    lista_n: ptnodo;

procedure esceva(m: string);
    begin
        writeln();
        writeln();
        writeln(m);
        writeln();
        writeln();
    end;

procedure criar_lista(var lista: ptnodo);
	begin
		lista := nil;
	end;

procedure inserir(var lista: ptnodo; inf: type_default);
    var aux, aux2, aux3: ptnodo;
        bool_while: boolean;
    begin
        new(aux);
        if aux = nil then
            begin
                esceva('Sem memória');
                readkey;
            end
        else
            // Inicia a lista
            if lista = nil then
                begin
                    aux^.dado := inf;
                    aux^.prox := nil;
                    lista := aux;
                end
            else
                begin
                    aux2 := lista;
                    aux3 := nil;
                    bool_while := TRUE;
                    while bool_while = TRUE do
                        begin
                            if aux2 = nil then
                                begin
                                    aux^.dado := inf;
                                    aux^.prox := nil;
                                    aux3^.prox := aux;
                                    bool_while := FALSE;
                                end
                            else if inf >= aux2^.dado then
                                begin
                                    aux3 := aux2;
                                    aux2 := aux2^.prox;
                                end
                            else if inf < aux2^.dado then
                                begin
                                    aux^.dado := inf;
                                    aux^.prox := aux2;
                                    if aux3 = nil then
                                        lista := aux
                                    else
                                        aux3^.prox := aux;
                                    bool_while := FALSE;
                                end;
                        end
                end;
    end;


procedure remover(var lista: ptnodo; inf: type_default);
    var aux, aux2: ptnodo;
    begin
        if lista = nil then
            begin
                writeln('Lista vazia!');
                readkey;
            end
        else
            begin
                aux2 := lista;
                aux3 := nil;
                bool_while := TRUE;
                while bool_while = TRUE do
                    begin
                        if aux2 = nil then
                            begin
                                aux^.dado := inf;
                                aux^.prox := nil;
                                aux3^.prox := aux;
                                bool_while := FALSE;
                            end
                        else if inf > aux2^.dado then
                            begin
                                aux3 := aux2;
                                aux2 := aux2^.prox;
                            end
                        else if inf < aux2^.dado then
                            begin

                                aux^.dado := inf;
                                aux^.prox := aux2;
                                if aux3 = nil then
                                    lista := aux
                                else
                                    aux3^.prox := aux;
                                bool_while := FALSE;
                            end;
                    end
            end;
    end;


procedure listar(lista: ptnodo);
    var aux : ptnodo;
		pos : integer;
	begin
		if lista = nil then
			esceva('Lista vazia!')
		else
			begin
				aux := lista;
				while aux <> nil do
					begin
						writeln(aux^.dado);
						aux := aux^.prox;
					end;
			end;
	end;


Begin
	op := 1;

	criar_lista(lista_n);

	while op <> 0 do
		Begin
			writeln('0 - Sair');
			writeln('1 - Inserir');
			writeln('2 - Remover');
			writeln('3 - Listar');

            writeln();
            writeln();
			readln(op);
			writeln();
            writeln();

			case op of
				1: begin
                    writeln('Informe um número:');
                    readln(n);
                    writeln();
                    writeln();
                    inserir(lista_n, n);
					end;
				2: begin
                    writeln('Informe o item da lista:');
                    remover(lista_n);
                    writeln();
                    writeln();
					end;
				3: begin
                    writeln('Aqui está a lista:');
                    listar(lista_n);
                    writeln();
                    writeln();
					end;
            end;
		End

End.