# crell
Crawl Erlang Source Code
===

1) clone repo

2) make rel

3) edit rel/crell/releases/1/sys.config
Under the crell application:
- enter a remote node
- enter the cookie for the remote node.
( The only currently implemented feature is remote loading the 
appmon code, option "1" in the sys.config )
- also choose port that's open on your firewall under "http_port"
 ( 8080 is normally ok )

4) rel/crell/bin/crell console

5) Visit
http://localhost:8080/

Create graphs of Erlang callgraph using xref.
===

./generate $DIR

* $DIR containing src/*.erl folder.
