Program tabela_hash;
uses sysutils;

const max = 99;

type
    vet = array[0..max] of string;
    TNodoCpf = ^TListaCpf;
    TListaCpf = record
        cpf: string;
        prox: TNodoCpf
    end;

var cpf: string;
    vHash: vet;
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
			escreva('CPF invalido');
			validaCpf := FALSE;
		end
	else
		begin
			pDigito := StrToIntDef(cpfValidar[10], 0);
			sDigito := StrToIntDef(cpfValidar[11], 0);
			sum := 0;
			for i := 10 to lengthCpf do
				begin
				    digito := StrToIntDef(cpfValidar[i], 0);
					for j := 1 to i - 1 do
						begin
                            writeln(i, ' - ', (j - 1), ' = ', i - (j - 1), ' * ', StrToIntDef(cpfValidar[j],0), ' = ', (StrToIntDef(cpfValidar[j],0) * (i - (j - 1))));
							sum := sum + (StrToIntDef(cpfValidar[j],0) * (i - (j - 1)));
						end;
					resto := sum mod 11;

                    writeln(sum);
                    writeln('Digito:', digito, 'Resto:', resto);

					if ((resto = 0) or (resto = 1)) and (digito <> 0) then
						begin
							writeln('CPF invalido, resto e 0 ou 1 e o digito e ', digito);
							validaCpf := FALSE;
						end
					else if (lengthCpf - resto) <> digito then
						begin
							writeln('CPF invalido, resto e ', resto, ' e o digito e ', digito);
							validaCpf := FALSE;
						end;
				end;
    		validaCpf := true;
		end;
end;

Begin

    op := 1;

    for i := 1 to max do
        vHash[i] := '';

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
                    validaCpf(cpf);
                    escreva('CPF incluido');
                end;
                2: begin
                    writeln('Informe o CPF que deseja remover:');
                    readln(cpf);
                    // removerCpf(cpf, vHash);
                end;
                3: begin
                    writeln('Lista de CPFs:');
                    // listaCpf();
                end;
            end;
        end;

End.