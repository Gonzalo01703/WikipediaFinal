#!"c:/Strawberry/perl/bin/perl.exe"

use strict;
use warnings;
use DBI;
use CGI;

 print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
<head>
    
    <link rel="stylesheet" type="text/css" href="../estiloUni.css">
    <title>Actor id 5 </title>
</head>
<body>
          
HTML
my $q = CGI->new;
my $titulo=$q->param("titulo");
my $contenido=$q->param("contenido");

if(defined $titulo && defined $contenido){
    my $user = 'alumno';
    my $password = 'pweb1';
    my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.9";
  
    my $dbh = DBI ->connect($dsn,$user,$password) or die ("No se pudo conectar");
    my $sth = $dbh->prepare("INSERT INTO Wiki (Titulo,Pagina) VALUES (?,?)" );

    $sth->execute($titulo,$contenido) or die "error"; 

    print <<HTML;
    <h1>$titulo</h1>
    <p>$contenido</p>
    <br>
    <h1>Pagina grabada <a href="listado.pl">Listado de paginas</a></h1>

HTML

}

if(!defined $titulo && !defined $contenido){
    print <<HTML;
    <div class="formulario">
    <form action="nuevaPag.pl">
        <p>Titulo</p>    
        <input type="text" name="titulo">
        <p>texto</p>
        <textarea name="contenido" style="height:500px;width:600px"></textarea><br>
        <input type="submit"><br>
        <a href="listado.pl">Cancelar</a>
    </form>
    </div>
HTML

}