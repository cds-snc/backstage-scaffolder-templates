module "ecs" {
  source = "github.com/cds-snc/terraform-modules//ecs?ref=v9.2.4"

  # Cluster and service
  create_cluster = ${{ values.create_cluster }} 
  cluster_name   = ${{ values.cluster_name | dump }}
  service_name = ${{ values.service_name | dump }} 

  # Task/Container definition
  container_image            = ${{ values.container_image | dump }} 
  task_cpu                   = ${{ values.task_cpu | dump }}  
  task_memory                = ${{ values.task_memory | dump }}  

  # Scaling
  enable_autoscaling = true

  # Networking
  security_group_ids  = ${{ values.security_group_ids | dump }}  
  subnet_ids          = ${{ values.subnet_ids| dump }}  

  billing_tag_value = ${{ values.billing_tag_value | dump }} 
}


resource "aws_cloudwatch_log_stream" "ecs_log_stream" {
  name           = "${{ values.service_name }}-log-stream"
  log_group_name = "/aws/ecs/${{ values.service_name }}"
}