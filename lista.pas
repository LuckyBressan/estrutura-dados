Program Lista;
uses crt;

type vet = array[1..99] of integer;

var i, n, base: integer;
    lista: vet;
    opcao: char;  
    
function listaVazia(b: integer): boolean;
begin
	listaVazia := (b = 0)
end;

function listaCheia(b, n: integer): boolean;
begin
	listaCheia := (b = n)
end;

procedure escreva(m: string);
begin
	writeln();
	writeln(m);
	writeln();
end;

procedure escrever(var a: vet; b: integer);
begin
	if(listaVazia(b)) then
		escreva('Lista vazia!')
	else
		begin
			escreva('Lista (Início ao fim)');
			for i := 1 to b do
				writeln('[', a[i], ']');
		end;
end;

procedure incluir(var a: vet; var b: integer; n: integer);
begin
	if(listaCheia(b, n)) then
		escreva('Lista cheia!')
	else 
		begin
			writeln('Informe o novo item da lista:');
			b := b + 1;
			readln(a[b]);
			escreva('Inserido com sucesso!');
		end;
end;

procedure remover(var a: vet; var b: integer);
begin
	if(listaVazia(b)) then
		escreva('Lista vazia!')
	else 
		begin
			a[b] := -1;
			b := b - 1;
			escreva('Removido com sucesso!');
		end;
end;


procedure consultar(var a: vet; b: integer);
var y: integer;
begin
	if(listaVazia(b)) then
		escreva('Lista vazia!')
	else 
		begin
			writeln('Informe a posição de consulta (', 1, ' a ', b, '):');
			readln(y);
			if(y > b) then
				escreva('Posição inválida!')
			else
				begin
					writeln('Número na posição ', y, ' é ', a[y]);
				end;
		end;
end;

Begin
	writeln('Informe o tamanho da lista: ');
	readln(n);
	
	for i := 1 to n do
		lista[i] := -1;
	
	base := 0;
	opcao := '0';
	
	while(opcao <> '5') do
		begin
			writeln('---- Opções da Lista: ----');
			writeln('1 - Escrever (Listar)');
			writeln('2 - Incluir (Push)');
			writeln('3 - Remover (Pop)');
			writeln('4 - Consultar');
			writeln('5 - Sair');
			
			opcao := readkey;
		
			writeln();
			if opcao = '1' then
				escrever(lista, base)
			else if opcao = '2' then
				incluir(lista, base, n)
			else if opcao = '3' then
				remover(lista, base)
			else if opcao = '4' then
				consultar(lista, base)
			else if opcao = '5' then 
				writeln('Adeus!')
			else
		    writeln('Opcao invalida!');
		    
			writeln();
		end;
End.