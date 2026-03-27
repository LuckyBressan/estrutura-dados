Program pilha;
uses crt;

type vet = array[1..99] of integer;

var i, n, topo: integer;
    pilha: vet;
    opcao: char;  
    
function pilhaCheia(t: integer; max: integer): boolean;
begin
	pilhaCheia := (t = max);	
end;

function pilhaVazia(t: integer): boolean;
begin
	pilhaVazia := (t = 0);
end;
	
procedure escreva(m: string);
begin
	writeln();
	writeln(m);
	writeln();
end;
	
procedure escrever(var a: vet; t: integer);
begin
	if (pilhaVazia(t)) then
	begin
		escreva('Pilha vazia!');
		exit;
	end;
	
	writeln('Pilha (do Topo para a Base):');
	for i := t downto 1 do
		writeln('[ ', a[i], ' ]');	
end;
    
procedure incluir(var a: vet; var t: integer; max: integer);
begin
	if (pilhaCheia(t, max)) then
	begin
		escreva('Pilha cheia! Nao e possivel empilhar.');
	end
	else 
	begin
		writeln('Informe o numero para o topo:');
		t := t + 1;
		readln(a[t]);
		escreva('Inserido com sucesso!');
	end;
end;
	
procedure remover(var a: vet; var t: integer);
begin
	if (pilhaVazia(t)) then
	begin
		escreva('Pilha vazia! Nao ha o que remover.');
		exit;
	end;
	
	writeln('Removendo o numero: ', a[t]);
	a[t] := -1;
	t := t - 1;
	escreva('Removido com sucesso!');
end;

procedure consultar(a: vet; t: integer);
var y: integer;
begin
	if (pilhaVazia(t)) then
	begin
		escreva('Pilha vazia!');
		exit;
	end;
	
	writeln('Informe a posicao (1 ate ', t, '): ');
	readln(y);
	
	if (y > t) or (y <= 0) then
		escreva('Posicao informada e invalida')
	else if (a[y] = -1) then
		escreva('Posicao vazia!')
	else 
		writeln('Numero na posicao ', y, ' e ', a[y]);
end;

Begin
	writeln('Informe a quantidade maxima de posicoes da pilha:');
	readln(n);
	
	for i := 1 to n do
		pilha[i] := -1;
			
	topo := 0;
	opcao := '0';
	
	while (opcao <> '5') do
	begin
		writeln('--- OPCOES DA PILHA ---');
		writeln('1 - Escrever (Listar)');
		writeln('2 - Incluir (Push)');
		writeln('3 - Remover (Pop)');
		writeln('4 - Consultar');
		writeln('5 - Sair');
		
		opcao := readkey;
		
		writeln();
		if opcao = '1' then
			escrever(pilha, topo)
		else if opcao = '2' then
			incluir(pilha, topo, n)
		else if opcao = '3' then
			remover(pilha, topo)
		else if opcao = '4' then
			consultar(pilha, topo)
		else if opcao = '5' then 
			writeln('Adeus!')
		else
		    writeln('Opcao invalida!');
		    
		writeln();
	end;
End.
