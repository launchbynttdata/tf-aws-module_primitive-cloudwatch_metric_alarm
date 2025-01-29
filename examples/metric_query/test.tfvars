alarm_description = "ELB Error Rate exceeds 10%"

comparison_operator = "GreaterThanOrEqualToThreshold"
threshold           = 10
evaluation_periods  = 2

treat_missing_data = "notBreaching"

metric_query = {
  "e1" = {
    expression  = "m2/m1*100"
    label       = "Error Rate"
    return_data = true
  }
  "m1" = {
    metric = {
      metric_name = "Request count"
      namespace   = "AWS/ApplicationELB"
      period      = 120
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = "app/example-load-balancer"
      }
    }
  }
  "m2" = {
    metric = {
      metric_name = "HTTPCode_ELB_5XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = 120
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = "app/example-load-balancer"
      }
    }
  }
}
