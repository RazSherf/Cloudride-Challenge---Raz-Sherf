# CloudWatch Log Group for ECS
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/hello-world"
  retention_in_days = 14

  tags = {
    Name = "hello-world-log-group"
  }
}

# SNS Topic for Alarms
resource "aws_sns_topic" "alerts" {
  name = "ecs-alerts"

  tags = {
    Name = "ecs-alerts-topic"
  }
}

# SNS Topic Subscription 
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "razsherf@gmail.com"  
}

# CloudWatch Alarm - Container Errors
resource "aws_cloudwatch_metric_alarm" "container_errors" {
  alarm_name          = "hello-world-container-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "ContainerInstanceErrorRate"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "0"
  alarm_description   = "This metric monitors container errors"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    ServiceName = aws_ecs_service.hello_world.name
    ClusterName = aws_ecs_cluster.main.name
  }

  tags = {
    Name = "container-errors-alarm"
  }
}

# CloudWatch Alarm - Service CPU Utilization
resource "aws_cloudwatch_metric_alarm" "service_cpu_high" {
  alarm_name          = "hello-world-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ecs cpu utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    ServiceName = aws_ecs_service.hello_world.name
    ClusterName = aws_ecs_cluster.main.name
  }

  tags = {
    Name = "cpu-utilization-alarm"
  }
}

# CloudWatch Alarm - Service Memory Utilization
resource "aws_cloudwatch_metric_alarm" "service_memory_high" {
  alarm_name          = "hello-world-memory-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ecs memory utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    ServiceName = aws_ecs_service.hello_world.name
    ClusterName = aws_ecs_cluster.main.name
  }

  tags = {
    Name = "memory-utilization-alarm"
  }
}

# CloudWatch Alarm - Unhealthy Host Count
resource "aws_cloudwatch_metric_alarm" "unhealthy_hosts" {
  alarm_name          = "hello-world-unhealthy-hosts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "0"
  alarm_description   = "This metric monitors unhealthy targets"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    TargetGroup  = aws_lb_target_group.hello_world.arn_suffix
    LoadBalancer = aws_lb.main.arn_suffix
  }

  tags = {
    Name = "unhealthy-hosts-alarm"
  }
}