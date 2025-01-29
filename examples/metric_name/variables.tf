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

variable "metric_name" {
  type        = string
  nullable    = true
  default     = null
  description = <<EOF
    The name for the metric associated with the alarm. For a list of
    AWS services and the metrics they publish, see the documentation
    here: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
  EOF
}

variable "namespace" {
  type        = string
  nullable    = true
  default     = null
  description = <<EOF
    The namespace for the alarm's associated metric. For a list of AWS
    namespaces, see the documentation here: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
  EOF
}

variable "period" {
  type        = number
  nullable    = true
  default     = null
  description = <<EOF
    The period, in seconds, over which the specified Statistic is applied.
    Valid values are 10, 30, and any multiple of 60.
  EOF

  validation {
    condition     = var.period == null ? true : var.period == 10 || var.period == 30 || var.period % 60 == 0
    error_message = "Period must be 10, 30, or a multiple of 60."
  }
}

variable "statistic" {
  type        = string
  nullable    = true
  default     = null
  description = <<EOF
    The statistic to apply to the alarm's associated metric. The value must be one of the following:
    `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`.
  EOF

  validation {
    condition     = var.period == null ? true : can(regex("SampleCount|Average|Sum|Minimum|Maximum", var.statistic))
    error_message = "Statistic must be one of: SampleCount, Average, Sum, Minimum, Maximum."
  }
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
