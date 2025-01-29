# metric_name

This example demonstrates monitoring a single metric by name directly.

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
| <a name="module_metric_alarm_by_metric_name"></a> [metric\_alarm\_by\_metric\_name](#module\_metric\_alarm\_by\_metric\_name) | ../.. | n/a |

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
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | The name for the metric associated with the alarm. For a list of<br/>    AWS services and the metrics they publish, see the documentation<br/>    here: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace for the alarm's associated metric. For a list of AWS<br/>    namespaces, see the documentation here: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html | `string` | `null` | no |
| <a name="input_period"></a> [period](#input\_period) | The period, in seconds, over which the specified Statistic is applied.<br/>    Valid values are 10, 30, and any multiple of 60. | `number` | `null` | no |
| <a name="input_statistic"></a> [statistic](#input\_statistic) | The statistic to apply to the alarm's associated metric. The value must be one of the following:<br/>    `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`. | `string` | `null` | no |
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
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
