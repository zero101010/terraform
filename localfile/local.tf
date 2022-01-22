// Crio o arquivo local
resource "local_file" "teste"{
    content = var.content
    filename = "test.txt"
}
// Gero um arquivo de log com o ID gerado pelo local_file.teste
resource "local_file" "logs"{
    content = resource.local_file.teste.id
    filename = "logs.txt"
    depends_on = [
        local_file.teste
    ]
}
// data source é uma estrutura para buscar os dados de um determinado resouce
data "local_file" "data-teste"{
    filename = "test.txt"
  
}

// Seta valor default de Variáveis
variable "content" {
  type = string
  default = "Hello world"
}
// Seta valor que esperamos no output
output "id-do-arquivo" {
  value = resource.local_file.teste.id
}

output "data-source-result" {
  value = "Id do resource" + data.local_file.data-teste
}