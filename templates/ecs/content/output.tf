################################################################################
# Cluster
################################################################################

output "arn" {
  description = "ARN that identifies the cluster"
  value       = ${{ values.create_cluster| dump }} ? module.ecs.arn : module.ecs.arn
}

output "cluster_id" {
  description = "ID that identifies the cluster"
  value       = ${{ values.create_cluster | dump }} ? module.ecs.id : ${{ values.cluster_name | dump }} 
}

output "cluster_name" {
  description = "Name that identifies the cluster"
  value       = ${{ values.cluster_name| dump }}  
}

################################################################################
# Service
################################################################################

output "service_id" {
  description = "ARN that identifies the service"
  value       = module.ecs.id
}

output "service_name" {
  description = "Name of the service"
  value       = module.ecs.name
}

################################################################################
# Task
################################################################################

output "task_definition_arn" {
  description = "Full ARN of the Task Definition (including both `family` and `revision`)"
  value       = module.ecs.aws_ecs_task_definition.this.arn
}

output "task_definition_revision" {
  description = "Revision of the task in a particular family"
  value       = module.ecs.aws_ecs_task_definition.this.revision
}

output "task_definition_family" {
  description = "The unique name of the task definition"
  value       = module.ecs.aws_ecs_task_definition.this.family
}

output "task_exec_role_arn" {
  description = "ARN of the ECS task execution role (used by ECS to initialize and manage the task)"
  value       = module.ecs.aws_iam_role.this_task_exec.arn 
}

output "task_role_arn" {
  description = "ARN of the ECS task role (used by the running task container)"
  value       = module.ecs.aws_iam_role.this_task.arn 
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = module.ecs.aws_cloudwatch_log_group.this.name
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = module.ecs.aws_cloudwatch_log_group.this.arn
}