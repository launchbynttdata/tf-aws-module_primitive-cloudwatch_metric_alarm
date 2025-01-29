metric_name       = "CPUUtilization"
namespace         = "AWS/EC2"
alarm_description = "EC2 CPU utilization alarm"

comparison_operator = "GreaterThanOrEqualToThreshold"
threshold           = 80
period              = 120
evaluation_periods  = 2
statistic           = "Average"

treat_missing_data = "notBreaching"
