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
    
    <link rel="stylesheet" type="text/css" href="../estiloList.css">
    <title>Lista de Paginas</title>
</head>
<body>
    <h1>Nuestras Paginas Wiki</h1>
          
HTML


my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.9";
  
my $dbh = DBI ->connect($dsn,$user,$password) or die ("No se pudo conectar");
 
my $sth = $dbh->prepare("SELECT Titulo FROM Wiki" );

$sth->execute or die "error";


  
print "<ol>";
while(my @row=$sth->fetchrow_array){
    
    print <<HTML;
    <form>
        <li><a href="ver.pl?titulo=$row[0]">$row[0]</a><a href="editar.pl?titulo=$row[0]">  E  </a><a href="borrar.pl?titulo=$row[0]">  X  </a></li>
    </form>
HTML

}
 
$sth ->finish;
$dbh->disconnect;                         


print <<HTML;
<br>


    <div style="text-align: center;" >
        <!--
            <a href="nuevaPag.pl">Nueva pagina</a>
            <a href="../inicio.html">Volver a inicio</a>
       -->
        <input class="boton" type="submit" value="Crear Nueva Pagina" onclick = "location='nuevaPag.pl'"/>
        <input class="boton" type="submit" value="Volver a Inicio" onclick = "location='../inicio.html'"/>

        
         <br>
         <br>
        <img  src="http://upload.wikimedia.org/wikipedia/en/thumb/8/80/Wikipedia-logo-v2.svg/500px-Wikipedia-logo-v2.svg.png" alt="img unsa" width="600px">


    </div>
    

HTML


