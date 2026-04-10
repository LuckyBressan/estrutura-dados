Program ponteiro_fila;

uses crt;

type
	type_default = integer;
	ptnodo = ^elemento;
	elemento = record;
		dado : type_default;
		prox : ptnodo
	end;

procedure leitura(var num: type_default);
	begin
		writeln('Informe um número:');
		readln(num);
	end;

procedure criar_fila(var fila: ptnodo);
	begin
		fila := nil;
	end;

procedure inserir(var fila: ptnodo; inf:type_default);
	var aux, aux2: ptnodo;
	begin
		new(aux);
		if aux = nil then
			begin
				write('Sem memória');
				readkey;
			end
		else
			if fila = nil then
				begin
					aux^.dado := inf;
					aux^.prox := nil;
					fila := aux;
				end
			else
				begin
					// armazena a fila
					aux2 := fila;
					// percorre toda a fila procurando o último elemento
					while aux2 <> nil do
						aux2 := aux2^.prox;
					aux^.dado := inf;
					aux^.prox := nil;
					// o último registro aponta para o novo último registro
					aux2^.prox := aux;
				end;
	end;

procedure listar(fila: ptnodo)
	var aux : ptnodo;
		pos : integer;
	begin
		if fila = nil then
			writeln('Fila vazia!')
		else
			begin
				pos := 1;
				aux := fila;
				while aux <> nil do
					begin
						pos := pos + 1;
						writeln(pos, ' - ', aux^.dado);
						aux := aux^.prox;
					end;
			end;
	end;

Begin
	op := 1;

	cria_fila(fila_n);

	while op <> 0 do
		Begin
			clrscr;
			writeln('0 - Sair');
			writeln('1 - Inserir');
			writeln('2 - Remover');
			writeln('3 - Listar');

			op := readkey;
			writeln()

			case op of
				1: begin

					end;
				2: begin

					end;
				3: begin

					end;
		End;

End.