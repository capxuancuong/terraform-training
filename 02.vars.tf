
# AWS credentials
variable "AWS_ACCESS_KEY" {
  description = "AWS_ACCESS_KEY"
}
variable "AWS_SECRET_KEY" {
  description = "AWS_SECRET_KEY"
}
variable "REGION" {
  description = "Region of project"
}

variable "vpc_cidr_block" {
  description = "vpc_cidr_block"
}
# # Project Info
variable "PROJECT" {
  description = "Project Name"
}
# variable "owner" {
#   description = "owner"
# }
# # VPC

# # Public Subnet
# variable "public_subnet_1_cidr" {
#   description = "public_subnet_1_cidr"
# }
# variable "public_subnet_2_cidr" {
#   description = "public_subnet_2_cidr"
# }
# variable "private_subnet_1_cidr" {
#   description = "private_subnet_1_cidr"
# }
# variable "private_subnet_2_cidr" {
#   description = "private_subnet_2_cidr"
# }
# variable "private_subnet_3_cidr" {
#   description = "private_subnet_3_cidr"
# }
# variable "private_subnet_4_cidr" {
#   description = "private_subnet_4_cidr"
# }

# # PORT CONFIG
# variable "frontend_port" {
#   description = "frontend_port"
# }
# variable "backend_port" {
#   description = "backend_port"
# }
# variable "database_port" {
#   description = "database_port"
# }


# #EC2 config
# variable "bastion_host_public_key" {
#   description = "bastion_host_public_key"
# }

# # Container
# variable "frontend_tag" {
#   description = "frontend_tag"
# }
# variable "frontend_container_name_01" {
#   description = "frontend_container_name"
# }
# variable "frontend_container_name_02" {
#   description = "frontend_container_name"
# }
# variable "backend_tag" {
#   description = "frontend_tag"
# }
# variable "backend_container_name_01" {
#   description = "backend_container_name"
# }
# variable "backend_container_name_02" {
#   description = "backend_container_name"
# }
# variable "ecs_frontend_cpu" {
#   description = "ecs_frontend_cpu"
# }
# variable "ecs_frontend_memmory" {
#   description = "ecs_frontend_memmory"
# }
# variable "ecs_backend_cpu" {
#   description = "ecs_backend_cpu"
# }
# variable "ecs_backend_memmory" {
#   description = "ecs_backend_memmory"
# }
# variable "database_instance_type" {
#   description = "database_instance_type"
# }

# variable "database_name" {
#   description = "database_name"
# }
# variable "database_username" {
#   description = "database_username"
# }
# variable "database_passwd" {
#   description = "database_passwd"
# }
# variable "database_storage" {
#   description = "database_storage"
# }

# ##Alarm Aurora

# variable "ok_actions" {
#   type        = list
#   default     = []
#   description = "A list of actions to take when alarms are cleared. Will likely be an SNS topic for event distribution."
# }
# variable "cpu_utilization_checks" {
#   type = number
#   default = 80
# }

# variable "cpu_utilization_periods" {
#   type    = number
#   default = 1
# }

# variable "cpu_utilization_period" {
#   type    = number
#   default = 60
# }

# variable "cpu_utilization_missing_data" {
#   type    = string
#   default = "notBreaching"
# }

# variable "freeable_memory_checks" {
#   type = number
#   default = 1024
#   description = "The amount of available random access memory, in megabytes"
# }

# variable "freeable_memory_periods" {
#   type    = number
#   default = 1
# }

# variable "freeable_memory_period" {
#   type    = number
#   default = 60
# }

# variable "freeable_memory_missing_data" {
#   type    = string
#   default = "notBreaching"
# }


# variable "free_storage_space_checks" {
#   type = number
#   default =  1024 * 3
#   description = "The amount of storage available for temporary tables and logs, in megabytes"
# }

# variable "free_storage_space_periods" {
#   type    = number
#   default = 1
# }

# variable "free_storage_space_period" {
#   type    = number
#   default = 60
# }

# variable "free_storage_space_missing_data" {
#   type    = string
#   default = "notBreaching"
# }

# variable "aurora_replica_lag_checks" {
#   type = number
#   default = 300
#   description = "For an Aurora Replica, the amount of lag when replicating updates from the primary instance, in milliseconds."
# }

# variable "aurora_replica_lag_periods" {
#   type    = number
#   default = 2
# }

# variable "aurora_replica_lag_period" {
#   type    = number
#   default = 60
# }

# variable "aurora_replica_lag_missing_data" {
#   type    = string
#   default = "notBreaching"
# }


# variable "database_connections_checks" {
#   type = number
#   default = 200
#   description = "Count of connections. Values related to database size"
# }

# variable "database_connections_periods" {
#   type    = number
#   default = 1
# }

# variable "database_connections_period" {
#   type    = number
#   default = 60
# }

# variable "database_connections_missing_data" {
#   type    = string
#   default = "notBreaching"
# }
# variable "volume_read_iops_checks" {
#   type = number
#   default = 600
#   description = "The number of IOPs in thousands"
# }

# variable "volume_read_iops_periods" {
#   type    = number
#   default = 1
# }

# variable "volume_read_iops_period" {
#   type    = number
#   default = 60 * 60
# }

# variable "volume_read_iops_missing_data" {
#   type    = string
#   default = "notBreaching"
# }

# variable "volume_read_iops_statistic" {
#   type    = string
#   default = "Average"
# }


# variable "volume_write_iops_checks" {
#   type = number
#   default = 600
#   description = "The number of IOPs in thousands"
# }

# variable "volume_write_iops_periods" {
#   type    = number
#   default = 1
# }

# variable "volume_write_iops_period" {
#   type    = number
#   default = 60 * 60
# }

# variable "volume_write_iops_missing_data" {
#   type    = string
#   default = "notBreaching"
# }

# variable "volume_write_iops_statistic" {
#   type    = string
#   default = "Average"
# }

# #### ECS alarm

# variable "HTTPCode_ELB_5XX_threshold" {
#   type        = string
#   description = "Threshold for ELB 5XX alert"
#   default     = "25"
# }
# variable "memory_alert_threshold" {
#   description = "Threshold which will trigger a alert when the memory crosses"
#   default     = "80"
# }
# variable "cpu_alert_threshold" {
#   description = "Threshold which will trigger a alert when the cpu crosses"
#   default     = "80"
# }