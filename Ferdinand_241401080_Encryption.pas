//Record
type message = record
text, hasil:string;
key:integer;
end;

//Prosedur (2) untuk enkripsi dan dekripsi
procedure encrypt(var pesan: message);
var
    i:integer;
    //Array
    arrayHasil: array of char;
begin
    setlength(arrayHasil, length(pesan.text));
    //Loop untuk mengisi arrayHasil dengan pesan yang dienkripsi
    for i:=1 to length(pesan.text) do
    begin
        //Jika berupa karakter, kita tambahkan value ASCIInya dengan key inputan user
        //+Conditionals untuk syarat
        if pesan.text[i] in ['A'..'Z'] then
            arrayHasil[i-1] := Chr(((Ord(pesan.text[i]) - Ord('A') + pesan.key) mod 26) + Ord('A'))
        else if pesan.text[i] in ['a'..'z'] then
            arrayHasil[i-1] := Chr(((Ord(pesan.text[i]) - Ord('a') + pesan.key) mod 26) + Ord('a'))
        //Tidak perlu diubah jika spasi/simbol
        else arrayHasil[i-1] := pesan.text[i]; 
    end;
    //Append satu persatu hasilnya dari isi arrayHasil
    pesan.hasil := '';
    for i:=0 to high(arrayHasil) do pesan.hasil := pesan.hasil + arrayHasil[i];
end;

//Prosedur dekripsi mirip dengan enkripsin, dengan value ASCII dikurangi key as opposed to ditambah
procedure decrypt(var pesan: message);
var
    i: integer;
    arrayHasil: array of char;
begin
    setlength(arrayHasil, length(pesan.text)); 
    for i:=1 to length(pesan.text) do
    begin
        if pesan.text[i] in ['A'..'Z'] then
            //Disini perbedaannya "-pesan.key"
            arrayHasil[i-1] := Chr(((Ord(pesan.text[i]) - Ord('A') - pesan.key + 26) mod 26) + Ord('A'))
        else if pesan.text[i] in ['a'..'z'] then
            arrayHasil[i-1] := Chr(((Ord(pesan.text[i]) - Ord('a') - pesan.key + 26) mod 26) + Ord('a'))
        else arrayHasil[i-1] := pesan.text[i];
    end;
    pesan.hasil := '';
    for i:=0 to high(arrayHasil) do pesan.hasil := pesan.hasil + arrayHasil[i];
end;

var
  input: message;
  pilih, stop: integer;

begin
    //Loop untuk program utama agar dapat diulang
    while True do
    begin
        with input do
        begin
            write('Masukkan pesan anda: '); readln(text); 
            write('Masukkan nilai key enkripsi (1-25): '); readln(key);
        end;

        writeln();
        writeln('Masukkan pilihan anda:');
        writeln('1. Encrypt');
        writeln('2. Decrypt');
        write('>> '); readln(pilih);

        if pilih = 1 then
        begin
            encrypt(input);
            writeln('Hasil enkripsi pesan: ', input.hasil);
        end
        else if pilih = 2 then
        begin
            decrypt(input);
            writeln('Hasil dekripsi pesan: ', input.hasil);
        end
        else writeln('Input tidak valid.');

        write('Lanjut? (0 untuk berhenti): '); readln(stop);
        //Ketik 0 untuk menghentikan program, selain 0 jika mau lanjut
        if stop = 0 then break;
    end;
end.
