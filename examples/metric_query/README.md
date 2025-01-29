# metric_query

This example demonstrates the use of the `metric_query` variable to compose a metric based on other metrics.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.14 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |
| <a name="module_metric_alarm_by_metric_query"></a> [metric\_alarm\_by\_metric\_query](#module\_metric\_alarm\_by\_metric\_query) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br/>    name       = string<br/>    max_length = optional(number, 60)<br/>    region     = optional(string, "eastus2")<br/>  }))</pre> | <pre>{<br/>  "alarm": {<br/>    "max_length": 80,<br/>    "name": "alrmbyname",<br/>    "region": "us-east-2"<br/>  }<br/>}</pre> | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br/>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br/>    For example, backend, frontend, middleware etc. | `string` | `"cloudwatch"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"demo"` | no |
| <a name="input_comparison_operator"></a> [comparison\_operator](#input\_comparison\_operator) | The arithmetic operation to use when comparing the specified Statistic and<br/>    Threshold. Normal alarms support the following values: `GreaterThanOrEqualToThreshold`, `GreaterThanThreshold`,<br/>    `LessThanThreshold`, `LessThanOrEqualToThreshold`. Anomaly detection alarms support the<br/>    following additional values: `LessThanLowerOrGreaterThanUpperThreshold`, `LessThanLowerThreshold`,<br/>    and `GreaterThanUpperThreshold`. | `string` | n/a | yes |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | The number of periods over which data is compared to the specified<br/>    threshold. | `number` | `3` | no |
| <a name="input_metric_query"></a> [metric\_query](#input\_metric\_query) | A map of objects that describes the metric queries associated with the alarm.<br/>    This is required if you are creating an alarm based on a metric math expression.<br/><br/>    If you specify a metric\_query, you may not specify a metric\_name, namespace, period, or<br/>    statistic on the same alarm. If you do not specify a metric query, you must specify each<br/>    of those fields.<br/><br/>    Within a metric query, you must specify either `metric` or `expression` but not both.<br/><br/>    The map's key will be used as the metric\_query's id. The id must be unique within the alarm.<br/>    If you are performing math expressions on this set of data, this name represents that data<br/>    and can serve as a variable in the mathematical expression. The valid characters are letters,<br/>    numbers, and underscore. The first character must be a lowercase letter.<br/><br/>    map(object({<br/>      account\_id  = (Optional) The ID of the account where the metrics are located, if this is a cross-account alarm.<br/>      label       = (Optional) A human-readable label for this metric or expression. This is especially useful if this is an expression, so that you know what the value represents.<br/>      period      = (Optional) Granularity in seconds of returned data points. For metrics with regular resolution, valid values are any multiple of 60. For high-resolution metrics, valid values are 1, 5, 10, 30, or any multiple of 60.<br/>      expression  = (Optional) The math expression to be performed on the returned data, if this object is performing a math expression. This expression can use the id of the other metrics to refer to those metrics, and can also use the id of other expressions to use the result of those expressions. For more information about metric math expressions, see https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html#metric-math-syntax.<br/>      metric      = optional(object({<br/>        metric\_name = (Required) The name for this metric.<br/>        namespace   = (Required) The namespace for this metric.<br/>        period      = (Required) Granularity in seconds of returned data points. For metrics with regular resolution, valid values are any multiple of 60. For high-resolution metrics, valid values are 1, 5, 10, 30, or any multiple of 60.<br/>        stat        = (Required) The statistic to apply to this metric. Refer to the description of the top-level `statistic` variable in this module for valid values.<br/>        unit        = (Optional) The unit for this metric. Refer to the description of the top-level `unit` variable in this module for valid values.<br/>        dimensions  = (Optional) The dimensions for this metric.<br/>      }))<br/>      return\_data = (Optional) Specify exactly one metric\_query to be true to use that metric\_query result as the alarm.<br/>    })) | <pre>map(object({<br/>    account_id = optional(string)<br/>    expression = optional(string)<br/>    label      = optional(string)<br/>    period     = optional(number)<br/>    metric = optional(object({<br/>      metric_name = string<br/>      namespace   = string<br/>      period      = number<br/>      stat        = string<br/>      unit        = optional(string)<br/>      dimensions  = optional(map(string))<br/>    }))<br/>    return_data = optional(bool, false)<br/>  }))</pre> | `null` | no |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The value against which the specified statistic is compared. This parameter<br/>    is required for alarms based on static thresholds, but should not be used for<br/>    alarms based on anomaly detection models. | `number` | `null` | no |
| <a name="input_treat_missing_data"></a> [treat\_missing\_data](#input\_treat\_missing\_data) | Sets how this alarm is to handle missing data points. The following values are supported:<br/>    `missing`, `ignore`, `breaching`, `notBreaching`. The default value is `missing`. | `string` | `"missing"` | no |
| <a name="input_alarm_description"></a> [alarm\_description](#input\_alarm\_description) | The description for the alarm. | `string` | `""` | no |
| <a name="input_threshold_metric_id"></a> [threshold\_metric\_id](#input\_threshold\_metric\_id) | If this is an alarm based on an anomaly detection model, make this value<br/>    match the ID of the ANOMALY\_DETECTION\_BAND function. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_alarm_name"></a> [alarm\_name](#output\_alarm\_name) | n/a |
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_metric_keys"></a> [metric\_keys](#output\_metric\_keys) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
