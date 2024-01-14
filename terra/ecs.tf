resource "aws_ecs_cluster" "ecs" {
  name = "app_cluster"

}

resource "aws_ecs_service" "service" {
  name = "app_service"
  ## referenciamos al cluster previamente creado
  cluster                = aws_ecs_cluster.ecs.arn
  launch_type            = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1

  network_configuration {
    assign_public_ip = true
    ## referenciamos el vpc de nuestro archivo vpc
    security_groups = [aws_security_group.sg.id]
    subnets         = [aws_subnet.sn1.id, aws_subnet.sn2.id, aws_subnet.sn3.id]
  }
}


resource "aws_ecs_task_definition" "td" {
    family = "app"
    container_definitions = jsonencode([
        {
            name= "app"

        }
    ])
  
}
