# Terraform

## O que é o terraform?
- É uma ferramenta voltada para a Infra como código. Após a criação alguns arquivos são criados para ajudar a gerenciar os pacotes e estados
## Estrutura de arquivos gerados pelo terraform
### .terraform.lock.hcl
- Registro de todos os providers e versões, como se fosse um gerenciador de pacote
### .terrafirn/providers/registry
- Baixa o arquivo binário do binário que vão ser utilizados
### terraform.tfstate
- É o arquivo que guarda o estado que a infraestrutura está, isso significa que caso você tenha subido uma infraestrutura e aplique alguma modificação o terraform não vai criar do zero, ele irá verificar o estado, modificar a partir desse estado e sobrescrever com a nova modificação.

### terraform.tfstate.backup
- Salva um backup do um estado anterior de uma modificação que foi feita e sobrescrita no terraform.tfstate, isso é muito útil caso seja necessário dar rollback


### Variávei de ambiente
#### variables.tfvars
- UM arquivo onde temos todas as envs setadas para substituir os arquivos decalrativos de terraform

#### Variáveis de ambiente
- É possível passar por variáveis de ambiente as envs usando o padrão TF_VAR_nome_da_variavel. Por exemplo, vamos supor que queremos setar a variável `content`, precisamos executar o seguinte comand:
 ```
 export TF_VAR_content="veio de variavel de ambiente" 
 ```

 ### Linha de comando
 - basta passar a flag `-var` e setar o valor, como por exemplo se quisermos a variável content:
 ```
 terraform apply -var="content=xpto" 
 ``` 