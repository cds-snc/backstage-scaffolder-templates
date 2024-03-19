################################################################################
# Cluster
################################################################################

output "arn" {
  description = "ARN that identifies the cluster"
  value       = module.ecs.arn
}

output "cluster_id" {
  description = "ID that identifies the cluster"
  value       = module.ecs.cluster_id
}

output "cluster_name" {
  description = "Name that identifies the cluster"
  value       = module.ecs.cluster_name
}

################################################################################
# Service
################################################################################

output "service_id" {
  description = "ARN that identifies the service"
  value       = module.ecs.service_id
}

output "service_name" {
  description = "Name of the service"
  value       = module.ecs.service_name
}

################################################################################
# Task
################################################################################

output "task_definition_arn" {
  description = "Full ARN of the Task Definition (including both `family` and `revision`)"
  value       = module.ecs.task_definition_arn
}

output "task_definition_revision" {
  description = "Revision of the task in a particular family"
  value       = module.ecs.task_definition_revision
}

output "task_definition_family" {
  description = "The unique name of the task definition"
  value       = module.ecs.task_definition_family
}

output "task_exec_role_arn" {
  description = "ARN of the ECS task execution role (used by ECS to initialize and manage the task)"
  value       = module.ecs.task_exec_role_arn
}

output "task_role_arn" {
  description = "ARN of the ECS task role (used by the running task container)"
  value       = module.ecs.task_role_arn
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = module.ecs.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = module.ecs.cloudwatch_log_group_arn
}