// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
    region     = optional(string, "eastus2")
  }))

  default = {
    alarm = {
      name       = "alrmbyname"
      max_length = 80
      region     = "us-east-2"
    }
  }
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0

  validation {
    condition     = var.instance_env >= 0 && var.instance_env <= 999
    error_message = "Instance number should be between 0 to 999."
  }
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0

  validation {
    condition     = var.instance_resource >= 0 && var.instance_resource <= 100
    error_message = "Instance number should be between 0 to 100."
  }
}

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "launch"
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "cloudwatch"
}

variable "class_env" {
  type        = string
  description = "(Required) Environment where resource is going to be deployed. For example. dev, qa, uat"
  nullable    = false
  default     = "demo"

  validation {
    condition     = length(regexall("\\b \\b", var.class_env)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "comparison_operator" {
  type        = string
  nullable    = false
  description = <<EOF
    The arithmetic operation to use when comparing the specified Statistic and
    Threshold. Normal alarms support the following values: `GreaterThanOrEqualToThreshold`, `GreaterThanThreshold`,
    `LessThanThreshold`, `LessThanOrEqualToThreshold`. Anomaly detection alarms support the
    following additional values: `LessThanLowerOrGreaterThanUpperThreshold`, `LessThanLowerThreshold`,
    and `GreaterThanUpperThreshold`.
  EOF
}

variable "evaluation_periods" {
  type        = number
  nullable    = false
  default     = 3
  description = <<EOF
    The number of periods over which data is compared to the specified
    threshold.
  EOF
}

variable "metric_query" {
  type = map(object({
    account_id = optional(string)
    expression = optional(string)
    label      = optional(string)
    period     = optional(number)
    metric = optional(object({
      metric_name = string
      namespace   = string
      period      = number
      stat        = string
      unit        = optional(string)
      dimensions  = optional(map(string))
    }))
    return_data = optional(bool, false)
  }))
  nullable    = true
  default     = null
  description = <<EOF
    A map of objects that describes the metric queries associated with the alarm.
    This is required if you are creating an alarm based on a metric math expression.

    If you specify a metric_query, you may not specify a metric_name, namespace, period, or
    statistic on the same alarm. If you do not specify a metric query, you must specify each
    of those fields.

    Within a metric query, you must specify either `metric` or `expression` but not both.

    The map's key will be used as the metric_query's id. The id must be unique within the alarm.
    If you are performing math expressions on this set of data, this name represents that data
    and can serve as a variable in the mathematical expression. The valid characters are letters,
    numbers, and underscore. The first character must be a lowercase letter.

    map(object({
      account_id  = (Optional) The ID of the account where the metrics are located, if this is a cross-account alarm.
      label       = (Optional) A human-readable label for this metric or expression. This is especially useful if this is an expression, so that you know what the value represents.
      period      = (Optional) Granularity in seconds of returned data points. For metrics with regular resolution, valid values are any multiple of 60. For high-resolution metrics, valid values are 1, 5, 10, 30, or any multiple of 60.
      expression  = (Optional) The math expression to be performed on the returned data, if this object is performing a math expression. This expression can use the id of the other metrics to refer to those metrics, and can also use the id of other expressions to use the result of those expressions. For more information about metric math expressions, see https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html#metric-math-syntax.
      metric      = optional(object({
        metric_name = (Required) The name for this metric.
        namespace   = (Required) The namespace for this metric.
        period      = (Required) Granularity in seconds of returned data points. For metrics with regular resolution, valid values are any multiple of 60. For high-resolution metrics, valid values are 1, 5, 10, 30, or any multiple of 60.
        stat        = (Required) The statistic to apply to this metric. Refer to the description of the top-level `statistic` variable in this module for valid values.
        unit        = (Optional) The unit for this metric. Refer to the description of the top-level `unit` variable in this module for valid values.
        dimensions  = (Optional) The dimensions for this metric.
      }))
      return_data = (Optional) Specify exactly one metric_query to be true to use that metric_query result as the alarm.
    }))
  EOF
}

variable "threshold" {
  type        = number
  nullable    = true
  default     = null
  description = <<EOF
    The value against which the specified statistic is compared. This parameter
    is required for alarms based on static thresholds, but should not be used for
    alarms based on anomaly detection models.
  EOF
}

variable "treat_missing_data" {
  type        = string
  nullable    = false
  default     = "missing"
  description = <<EOF
    Sets how this alarm is to handle missing data points. The following values are supported:
    `missing`, `ignore`, `breaching`, `notBreaching`. The default value is `missing`.
  EOF
}

variable "alarm_description" {
  type        = string
  nullable    = false
  default     = ""
  description = "The description for the alarm."
}

variable "threshold_metric_id" {
  type        = string
  nullable    = true
  default     = null
  description = <<EOF
    If this is an alarm based on an anomaly detection model, make this value
    match the ID of the ANOMALY_DETECTION_BAND function.
  EOF
}

variable "tags" {
  type        = map(string)
  nullable    = false
  default     = {}
  description = "A mapping of tags to assign to the resource."
}
