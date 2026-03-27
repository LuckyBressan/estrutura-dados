Program ex_fila_1;

type vet = array[1..99] of integer;

var i, n, qtd_pos: integer;
    fila: vet;
    opcao: char;  
    
function filaCheia(qtd: integer; max: integer): boolean;
	begin
		filaCheia := qtd = max;	
	end;

function filaVazia(qtd: integer): boolean;
	begin
		filaVazia := qtd = 0;
	end;
	
procedure escreva(m: varchar);
	begin
	writeln();
	writeln();
	writeln(m);
	writeln();
	writeln();
	end;
	
procedure listar(
 	var a: vet;
	x: integer
);
	begin
		writeln('Fila:');
		for i := 1 to x do
			write(fila[i], ' ');	
	end;
    
procedure inserir(
	var a: vet;
	var qtd: integer;
	x: integer
);
	begin
		if(filaCheia(qtd, x) = TRUE) then
			begin
				escreva('Fila cheia!')
			end
		else 
			begin
				writeln('Informe o número:');
				qtd := qtd + 1;
				readln(fila[qtd]);
			end;
	end;
	
procedure remover(
	var a: vet;
	var qtd: integer;
	x: integer
);
	begin
		if(filaVazia(qtd)) then
			begin
				escreva('Fila vazia!');
				exit;
			end;
		for i := 1 to n do
			a[i] := a[i + 1];
		a[x] := -1;
		qtd := qtd - 1;
	end;

procedure consultar(
	a: vet;
	x, qtd: integer
);
	var y: integer;
	begin
		if(filaVazia(qtd)) then
			begin
				escreva('Fila vazia!')
				exit;
			end;
		writeln('Informe a posição: ');
		readln(y);
		if (y > x) or (y <= 0) then
			escreva('Posição informada é inválida')
		else if(a[y] = -1) then
			escreva('Posição vazia!')
		else 
			writeln('Número na posição ', y, ' é ', a[y]);
	end;

Begin
	writeln('Informe a quantidade de posições da fila:');
	readln(n);
	// "Preenchemos" o array com um indicativo vazio para validação
	for i := 1 to n do
			fila[i] := -1;
	qtd_pos := 0;		
	while (opcao <> '5') do
		begin
			writeln('Escolha as operações:');
			writeln('1 - Listar');
			writeln('2 - Inserir');
			writeln('3 - Remover');
			writeln('4 - Consultar');
			writeln('5 - Sair');
			opcao := readkey;
			
			writeln();
			writeln();
			if opcao = '1' then
				listar(fila, n)
			else if opcao = '2' then
			  inserir(fila, qtd_pos, n)
			else if opcao = '3' then
				remover(fila, qtd_pos, n)
			else if opcao = '4' then
			  consultar(fila, qtd_pos, n)
			else if opcao = '5' then 
				writeln('Adeus!');
			writeln();
			writeln();
		end
	
End.