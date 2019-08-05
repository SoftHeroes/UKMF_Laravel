for %%f in (*.sql) do (mysql -h localhost -u root MYSQL < "%cd%\%%f") > "%%f.out" 2>&1
