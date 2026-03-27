Program truco;

type 
    Carta = record 
        naipe: integer; // 1 - 4 (ouros, espadas, copas, paus)
        peso: integer; // "valor" da carta
        numero: integer; // número da carta
        posicao: integer; // posição da carta no baralho
    end;

    baralho_carta = array [1..40] of Carta;

var 
    baralho : baralho_carta;
    i, max : integer;

const max := 40;

procedure escreva(m: string);
begin
    writeln();
    writeln(m);
    writeln();
end;

procedure embaralhar(var a: baralho_carta);
begin
    // for i := 1 to max do
    //     a[i] := 
    escreva('Cartas embaralhadas!');
end;


begin
    
end;