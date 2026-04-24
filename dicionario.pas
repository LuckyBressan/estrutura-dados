Program dicionario_atividade;

type
    TNodoChave = ^TPalavraChave
    TListaChave = record

    end;
    TPalavraChave = record
        ant : TNodoChave;
        prox : TNodoChave
    end;

procedure incluirPalavraChave(var listaC; p: string)
begin
end;

Begin

    op := 1;

    while op <> 0 do
        begin
            writeln('1 - Cadastrar palavra chave');
            writeln('2 - Incluir tradução');
            writeln('3 - Remover tradução');
            writeln('4 - Consultar dicionário');
            writeln('5 - Escrever dicionário');
            case op of
                1: Begin
                    writeln('Informe a palavra chave:');
                    readln(p);
                    incluirPalavraChave(listaChave, p);
                end;
                2: Begin
                end;
                3: Begin
                end;
                4: Begin
                end;
                5: Begin
                end;
        end;

End.