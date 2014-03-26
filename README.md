SCUTUM
======

O SCUTUM é um conjunto de soluções OpenSource com o intuito de facilitar a vida do desenvolver Object Pascal!

Soluções planejadas:
- SCUTUMConnection : Abstract Factory para banco de dados [em desenvolvimento]
- SCUTUMSerialize : Serialização JSON/XML [em desenvolvimento]
- SCUTUMorm : ORM [não inicializado]

SCUTUM Connection
=================
O SCUTUM Connection é uma solução do tipo Abstract Factory (GoF) idealizada para permitir que o desenvolvedor desenhe suas 
soluções voltadas a uma interface única para acesso ao banco de dados e não se preocupe com particularidades de um SGBD 
ou um framework de acesso, fazendo assim com que uma possível mudança de SGBD ou até mesmo no framework de acesso, seja 
transparente para a aplicação.

Hoje o framework já está encapsulando as seguintes classes concretas:
- Firebird com DBExpress
- Firebird com FireDac
- SQL Server com FireDac
