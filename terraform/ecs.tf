# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "hello-world-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "hello-world-cluster"
    Environment = "dev"
  }
}

# ECS Task Definition
resource "aws_ecs_task_definition" "hello_world" {
  family                   = "hello-world-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name  = "hello-world"
      image = var.ecr_image_url
      
      portMappings = [
        {
          containerPort = 80
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }

      essential = true
    }
  ])

  tags = {
    Name = "hello-world-task-definition"
  }
}

# ECS Service
resource "aws_ecs_service" "hello_world" {
  name            = "hello-world-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.hello_world.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private_subnets[*].id
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.hello_world.arn
    container_name   = "hello-world"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.hello_world]

  tags = {
    Name = "hello-world-service"
  }
}