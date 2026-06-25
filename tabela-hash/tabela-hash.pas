Program tabela_hash;
uses sysutils;

const max = 99;

type
    TNodoCpf = ^TListaCpf;
    TListaCpf = record
        cpf: string;
        prox: TNodoCpf
    end;
    vetCpf = array[0..max] of TNodoCpf;

var cpf: string;
    vHash: vetCpf;
    i, qtd_elem: integer;
    op: byte;

procedure escreva(m: string);
    begin
        writeln();
        writeln();
        writeln(m);
        writeln();
        writeln();
    end;

function validaCpf(var cpfValidar: string): boolean;
const lengthCpf = 11;
var digito, sum, k, j, resto, esperado : integer;
    valido : boolean;
begin
	valido := TRUE;

	if Length(cpfValidar) <> lengthCpf then
		valido := FALSE
	else
		for k := 10 to lengthCpf do
			begin
				digito := StrToIntDef(cpfValidar[k], 0);
				sum := 0;
				for j := 1 to k - 1 do
					sum := sum + (StrToIntDef(cpfValidar[j], 0) * (k - (j - 1)));

				resto := sum mod 11;

				if resto < 2 then
					esperado := 0
				else
					esperado := 11 - resto;

				if digito <> esperado then
					valido := FALSE;
			end;

	validaCpf := valido;
end;

function hash(cpf: string): integer;
begin
    hash := StrToIntDef(cpf[10] + cpf[11], 0);
end;

procedure inserirCpf(var tabCpf: vetCpf; cpfNovo: string);
var 
    hashCpf : integer;
    novo: TNodoCpf;
begin

    if validaCpf(cpfNovo) = FALSE then
        escreva('CPF informado e invalido!');
    else 
        begin
            hashCpf := hash(cpfNovo);

            new(novo);

            if novo = nil then
                escreva('Sem memória!')
            else 
                begin
                    novo^.cpf := cpfNovo;
                    novo^.prox := tabCpf[hashCpf];
                    tabCpf[hashCpf] := novo;

                    escreva('CPF inserido com sucesso!');
                end;
        end;
end;

procedure listarCpf(tabCpf: vetCpf);
var listaVazia : boolean;
    aux : TNodoCpf;
begin
    escreva('Inicio da listagem!');
    listaVazia := TRUE;

    for i := 0 to MAX - 1 do
        if tabCpf[i] <> nil then
            begin
                listaVazia := FALSE;
                writeln();
                writeln('Chave: ', i);

                aux := tabCpf[i];

                while aux <> nil do
                    begin
                        writeln(aux^.cpf);
                        aux := aux^.prox;
                    end;

            end;
    
    if listaVazia = TRUE then
        escreva('Nenhum CPF estava cadastrado!');
    escreva('Fim da listagem!');
end;

procedure buscarCpf(tabCpf: vetCpf; cpfBusca: string);
var 
    hashCpf : integer;
    aux: TNodoCpf;
begin

    if validaCpf(cpfBusca) = FALSE then
        escreva('CPF informado é invalido!');
    else
        begin
            hashCpf := hash(cpfBusca);
            aux := tabCpf[hashCpf];

            while (aux <> nil) and (aux^.cpf <> cpfBusca) do
                aux := aux^.prox;

            if aux <> nil then
                escreva('CPF informado esta na lista!')
            else 
                escreva('CPF informado nao esta na lista!');
        end;
end;

Begin

    op := 1;

    for i := 1 to max do
        vHash[i] := nil;

    while op <> 0 do
        begin
            writeln('0 - Sair');
            writeln('1 - Cadastrar CPF');
            writeln('2 - Remover CPF');
            writeln('3 - Listar CPFs');
            writeln('4 - Buscar CPF');

            writeln();
            writeln();
			readln(op);
			writeln();
            writeln();

            case op of
                1: begin
                    writeln('Informe o CPF:');
                    readln(cpf);
                    inserirCpf(vHash, cpf);
                end;
                2: begin
                    writeln('Informe o CPF que deseja remover:');
                    readln(cpf);
                end;
                3: begin
                    writeln('Lista de CPFs:');
                    listarCpf(vHash);
                end;
                4: begin
                    writeln('Buscar CPF:');
                    readln(cpf);
                    buscarCpf(vHash, cpf);
                end;
            end;
        end;

End.