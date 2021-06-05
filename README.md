# Docker: MySQL + ProxySQL + PMM

Lab apenas para testar o ProxySQL junto com o Percona Server(MySQL) nas últimas versões e seu comportamento. 
O composer criará:
- 2 MySQL Servers em async replication (mysql_1 -> mysql_2)
- 1 ProxySQL já configurado utilizando o proxysql.cnf
- 1 Pmm Server sem configuração. Default user(admin:admin)

O ProxySQL da Sysown ainda não suporta o novo plugin de autenticação `caching_sha256_password`, então foi necessário criar todos os usuários usando o antigo `mysql_native_password`. 


## Execução

Para executar, apenas clonar o repositório:

```
git clone ..../lab-docker-mysql-1
cd lab-docker-mysql-1

# Para informações de usuário e senha, por favor leia o composer e as envs vars configuradas.
# Para rodar em background (-d)
docker compose up 
```

Para acessar o PMM: `https://admin:admin@localhost:443`

Para verificar os containers que estão rodando: `[sudo] docker ps`

O script `sysbench.sh` contêm a imagem pré configurada da ferramenta sysbench para realizar testes de cargas e simular uma carga de trabalho para testes.


Após realizar todos os testes, apenas rodar o `cleanup.sh` para remover todos os containers.
