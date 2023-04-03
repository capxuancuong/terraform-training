# Public_subnet_1
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  public_subnet_cidrs = ["172.17.0.0/24", "172.17.1.0/24"]
  private_subnet_cidrs = ["172.17.2.0/24", "172.17.3.0/24"]
  db_subnet_cidrs = ["172.17.4.0/24", "172.17.5.0/24"]
  public_zone =  [data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
  private_zone = [data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
}

#VPC
resource "aws_vpc" "chinhlt_vpc" {
  cidr_block = "172.17.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = format("%s-vpc", var.PROJECT)
    Project = var.PROJECT
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(local.public_subnet_cidrs)

  vpc_id = aws_vpc.chinhlt_vpc.id
  cidr_block = local.public_subnet_cidrs[count.index]
  availability_zone = local.public_zone[count.index % length(local.public_zone)]
  tags = {
    "Name" = format("%s-public-subnet-${count.index+1}", var.PROJECT)
    Project = var.PROJECT
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(local.private_subnet_cidrs)

  vpc_id = aws_vpc.chinhlt_vpc.id
  cidr_block = local.private_subnet_cidrs[count.index]
  availability_zone = local.private_zone[count.index % length(local.private_zone)]

  tags = {
    "Name" = format("%s-private-subnet-${count.index+1}", var.PROJECT)
    Project = var.PROJECT
  }
}
resource "aws_subnet" "db_subnet" {
  count = length(local.db_subnet_cidrs)

  vpc_id = aws_vpc.chinhlt_vpc.id
  cidr_block = local.db_subnet_cidrs[count.index]
  availability_zone = local.private_zone[count.index % length(local.private_zone)]

  tags = {
    "Name" = format("%s-db-subnet-${count.index+1}", var.PROJECT)
    Project = var.PROJECT
  }
}

resource "aws_internet_gateway" "chinhlt_igw" {
  vpc_id = aws_vpc.chinhlt_vpc.id

  tags = {
    "Name" = format("%s-igw", var.PROJECT)
    Project = var.PROJECT
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.chinhlt_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.chinhlt_igw.id
  }

  tags = {
    "Name" = "chinhlt_rt_public"
  }
}
resource "aws_route_table_association" "public_association" {
  for_each = {for k, v in aws_subnet.public_subnet: k => v}
  subnet_id = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "chinhlt_nat" {
  vpc = true
}

resource "aws_nat_gateway" "public" {
  # depends_on = [
  #   aws_internet_gateway.chinhlt_igw
  # ]

  allocation_id = aws_eip.chinhlt_nat.id
  subnet_id = aws_subnet.public_subnet[1].id

  tags = {
    "Name" = "chinhlt_nat"
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.chinhlt_vpc.id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public.id
  }

  tags = {
    "Name" = "chinhlt_rt_private"
  }
}
resource "aws_route_table_association" "public_private" {
  for_each = {for k,v in aws_subnet.private_subnet : k => v}
  subnet_id = each.value.id
  route_table_id = aws_route_table.private.id
}
# resource "aws_vpc" "vpc" {
#   cidr_block           = var.vpc_cidr_block
#   enable_dns_support   = true
#   enable_dns_hostnames = true
#   # tags = { 
#   #   Project = var.PROJECT 
#   #   Name      = format("%s-vpc", var.PROJECT)
#   #   CreatedBy = var.owner
#   # }
# }
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.vpc.id
#   tags = { 
#     Project = var.PROJECT 
#     Name      = format("%s-igw", var.PROJECT)
#     CreatedBy = var.owner
#   }
# }


# #Public Subnet
# resource "aws_subnet" "public_subnet_1" {
#   availability_zone       = data.aws_availability_zones.available.names[0]
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.public_subnet_1_cidr
#   map_public_ip_on_launch = "true"
#   tags = { 
#     Project = var.PROJECT 
#     Name      = format("%s-public-subnet-1", var.PROJECT)
#     CreatedBy = var.owner
#   }
# }

# resource "aws_subnet" "public_subnet_2" {
#   availability_zone       = data.aws_availability_zones.available.names[1]
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.public_subnet_2_cidr
#   map_public_ip_on_launch = "true"
#   tags = { 
#     Project = var.PROJECT 
#     Name      = format("%s-public-subnet-2", var.PROJECT)
#     CreatedBy = var.owner
#   }
# }
# #Private Subnet
# resource "aws_subnet" "private_subnet_1" {
#   availability_zone       = data.aws_availability_zones.available.names[0]
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.private_subnet_1_cidr
#   map_public_ip_on_launch = "false"
#   tags = { 
#     Project = var.PROJECT
#     Name      = format("%s-private-subnet-1", var.PROJECT)
#     CreatedBy = var.owner
#   }
# }
# resource "aws_subnet" "private_subnet_2" {
#   availability_zone       = data.aws_availability_zones.available.names[1]
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.private_subnet_2_cidr
#   map_public_ip_on_launch = "false"
#   tags = { 
#     Project = var.PROJECT 
#     Name      = format("%s-private-subnet-2", var.PROJECT)
#     CreatedBy = var.owner
#   }
# }

# #Private Subnet Database
# resource "aws_subnet" "private_subnet_3" {
#   availability_zone       = data.aws_availability_zones.available.names[0]
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.private_subnet_3_cidr
#   map_public_ip_on_launch = "false"
#   tags = { 
#     Project = var.PROJECT 
#     Name      = format("%s-private-subnet-3", var.PROJECT)
#     CreatedBy = var.owner
#   }
# }
# resource "aws_subnet" "private_subnet_4" {
#   availability_zone       = data.aws_availability_zones.available.names[1]
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.private_subnet_4_cidr
#   map_public_ip_on_launch = "false"
#   tags = { 
#     Project = var.PROJECT 
#     Name      = format("%s-private-subnet-4", var.PROJECT)
#     CreatedBy = var.owner
#   }
# }


# #Create database subnet group 
# resource "aws_db_subnet_group" "database_subnet_group" {
#   name = format("%s-db-subnet-gr", var.PROJECT)
#   subnet_ids = [
#     aws_subnet.private_subnet_3.id, aws_subnet.private_subnet_4.id
#   ]

#   tags = { 
#     Project = var.PROJECT 
#     Name      = format("%s-db-subnet-gr", var.PROJECT)
#     CreatedBy = var.owner
#   }
# }

# #############
# # Route Tables
# #############


# resource "aws_route_table" "publicRT" {
#   vpc_id = aws_vpc.vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }
#   tags = { 
#     Project = var.PROJECT 
#     Name      = format("%s-publicRT", var.PROJECT)
#     CreatedBy = var.owner
#   }
# }
# #############
# #  Route associations public
# #############
# resource "aws_route_table_association" "public_1_RT" {
#   subnet_id      = aws_subnet.public_subnet_1.id
#   route_table_id = aws_route_table.publicRT.id
# }
# resource "aws_route_table_association" "public_2_RT" {
#   subnet_id      = aws_subnet.public_subnet_2.id
#   route_table_id = aws_route_table.publicRT.id
# }

# #############
# #  NAT config for private subnet
# #############

# resource "aws_eip" "elastic_ip_1" {
#   vpc = true
#   tags         = {
#           "Name" = format("%s-nat-gateway-01", var.PROJECT)
#         }
# }

# # resource "aws_eip" "elastic_ip_2" {
# #   vpc = true
# # }
# # resource "aws_nat_gateway" "nat_gateway_1" {
# #   allocation_id = aws_eip.elastic_ip_1.id
# #   subnet_id     = aws_subnet.public_subnet_1.id
# #   tags = { 
# #     Project = var.PROJECT 
# #     Name      = format("%s-nat-gateway-01", var.PROJECT)
# #     CreatedBy = var.owner
# #   }
# # }
# # resource "aws_route_table" "route_table_01" {
# #   vpc_id = aws_vpc.vpc.id
# #   route {
# #     cidr_block = "0.0.0.0/0"
# #     gateway_id = aws_nat_gateway.nat_gateway_1.id
# #   }
# #   lifecycle {
# #     ignore_changes = [
# #       route
# #     ]
# #   }
# #   tags = { 
# #     Project = var.PROJECT 
# #     Name      = format("%s-privateRoute01", var.PROJECT)
# #     CreatedBy = var.owner
# #   }
# # }
# # resource "aws_route_table_association" "route_table_association_01" {
# #   subnet_id      = aws_subnet.private_subnet_1.id
# #   route_table_id = aws_route_table.route_table_01.id
# # }
# # resource "aws_route_table_association" "route_table_association_02" {
# #   subnet_id      = aws_subnet.private_subnet_3.id
# #   route_table_id = aws_route_table.route_table_01.id
# # }

# # resource "aws_route_table_association" "route_table_association_03" {
# #   subnet_id      = aws_subnet.private_subnet_2.id
# #   route_table_id = aws_route_table.route_table_01.id
# # }
# # resource "aws_route_table_association" "route_table_association_04" {
# #   subnet_id      = aws_subnet.private_subnet_4.id
# #   route_table_id = aws_route_table.route_table_01.id
# # }

# # resource "aws_nat_gateway" "nat_gateway_2" {
# #   allocation_id = aws_eip.elastic_ip_2.id
# #   subnet_id     = aws_subnet.public_subnet_2.id
# #   tags = { 
# #     Project = var.PROJECT 
# #     Name      = format("%s-nat-gateway-02", var.PROJECT)
# #     CreatedBy = var.owner
# #   }
# # }
# # resource "aws_route_table" "route_table_02" {
# #   vpc_id = aws_vpc.vpc.id
# #   route {
# #     cidr_block = "0.0.0.0/0"
# #     gateway_id = aws_nat_gateway.nat_gateway_2.id
# #   }
# #   lifecycle {
# #     ignore_changes = [
# #       route
# #     ]
# #   }
# #   tags = { 
# #     Project = var.PROJECT 
# #     Name      = format("%s-privateRoute02", var.PROJECT)
# #     CreatedBy = var.owner
# #   }
# # }
# # resource "aws_route_table_association" "route_table_association_03" {
# #   subnet_id      = aws_subnet.private_subnet_2.id
# #   route_table_id = aws_route_table.route_table_02.id
# # }
# # resource "aws_route_table_association" "route_table_association_04" {
# #   subnet_id      = aws_subnet.private_subnet_4.id
# #   route_table_id = aws_route_table.route_table_02.id
# # }