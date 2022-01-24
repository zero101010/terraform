// Cria a VPC geral
resource "aws_vpc" "new_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.prefix}"
  }
}
// Verifica o tipo de zonas possíveis 
data "aws_availability_zones" "available" {

}
// Printa as zonas 
output "az" {
  value = data.aws_availability_zones.available.names
}

// cria a subnet usando laço de repetição que vai iterar 2 vezes de acordo com o count
resource "aws_subnet" "subnets" {
  count = 2
  // Vai iterando sobre a as zonas de disponibilidades que são retornadas 
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.new_vpc.id
  // Adiciona no bloco de ip o valor iterado de count
  cidr_block = "10.0.${count.index}.0/24"
  // Cria um Ip público para minha subnet
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-subnet-${count.index}"
  }
}

// Criando porta de entrada com internetgateway
resource "aws_internet_gateway" "new-igw" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "new_rtb" {
  vpc_id = aws_vpc.new_vpc.id
  route  {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.new-igw.id
  }
  tags = {
    Name = "${var.prefix}-rtb"
  }
}

resource "aws_route_table_association" "new-rtb-association" {
  count = 2
  route_table_id = aws_route_table.new_rtb.id
  subnet_id = aws_subnet.subnets.*.id[count.index]

}