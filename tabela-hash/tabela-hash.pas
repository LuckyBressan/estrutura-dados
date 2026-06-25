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
var pDigito, sDigito, digito, sum, j, resto : integer;
begin
	if Length(cpfValidar) <> lengthCpf then
		begin
			validaCpf := FALSE;
		end
	else
		begin
			pDigito := StrToIntDef(cpfValidar[10], 0);
			sDigito := StrToIntDef(cpfValidar[11], 0);
			for i := 10 to lengthCpf do
				begin
				    digito := StrToIntDef(cpfValidar[i], 0);
                    sum := 0;
					for j := 1 to i - 1 do
						begin
							sum := sum + (StrToIntDef(cpfValidar[j],0) * (i - (j - 1)));
						end;
					resto := sum mod 11;

					if ((resto = 0) or (resto = 1)) and (digito <> 0) then
						begin
							validaCpf := FALSE;
						end
					else if (lengthCpf - resto) <> digito then
						begin
							validaCpf := FALSE;
						end;
				end;
    		validaCpf := true;
		end;
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
        begin
            escreva('CPF informado é invalido!');
        end
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
end;

procedure buscarCpf(tabCpf: vetCpf; cpfBusca: string);
var 
    hashCpf : integer;
    aux: TNodoCpf;
begin
    hashCpf := hash(cpfBusca);
    aux := tabCpf[hashCpf];

    while (aux <> nil) and (aux^.cpf <> cpfBusca) do
        aux := aux^.prox;

    if aux <> nil then
        escreva('CPF informado esta na lista!')
    else 
        escreva('CPF informado não esta na lista!');
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
            end;
        end;

End.