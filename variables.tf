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

variable "alarm_name" {
  type        = string
  nullable    = false
  description = "Descriptive name for an alarm. This name must be unique within the AWS account."
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

variable "threshold_metric_id" {
  type        = string
  nullable    = true
  default     = null
  description = <<EOF
    If this is an alarm based on an anomaly detection model, make this value
    match the ID of the ANOMALY_DETECTION_BAND function.
  EOF
}

variable "actions_enabled" {
  type        = bool
  nullable    = false
  default     = true
  description = <<EOF
    Indicates whether or not actions should be executed during any changes to the alarm's state.
  EOF
}

variable "alarm_actions" {
  type        = list(string)
  nullable    = false
  default     = []
  description = <<EOF
    The list of actions to execute when this alarm transitions into an ALARM state from any other state.
    Each action is specified as an Amazon Resource Name (ARN).
  EOF
}

variable "alarm_description" {
  type        = string
  nullable    = false
  default     = ""
  description = "The description for the alarm."
}

variable "datapoints_to_alarm" {
  type        = number
  nullable    = true
  default     = null
  description = <<EOF
    The number of data points that must be breaching to trigger the alarm.
    This is used only if you are setting an "M out of N" alarm. In that case,
    this value is the M. For more information, see Evaluating an Alarm in the
    Amazon CloudWatch User Guide.
  EOF
}

variable "dimensions" {
  type        = map(string)
  nullable    = true
  default     = null
  description = <<EOF
    The dimensions for the alarm's associated metric. For a list of AWS
    services and the dimensions they publish, see the documentation here:
    https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
  EOF
}

variable "insufficient_data_actions" {
  type        = list(string)
  nullable    = false
  default     = []
  description = <<EOF
    The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state.
    Each action is specified as an Amazon Resource Name (ARN).
  EOF
}

variable "ok_actions" {
  type        = list(string)
  nullable    = false
  default     = []
  description = <<EOF
    The list of actions to execute when this alarm transitions into an OK state from any other state.
    Each action is specified as an Amazon Resource Name (ARN).
  EOF
}

variable "unit" {
  type        = string
  nullable    = true
  default     = null
  description = <<EOF
    The unit of the alarm's associated metric. Valid values: `Seconds`,
    `Microseconds`, `Milliseconds`, `Bytes`, `Kilobytes`, `Megabytes`,
    `Gigabytes`, `Terabytes`, `Bits`, `Kilobits`, `Megabits`, `Gigabits`,
    `Terabits`, `Percent`, `Count`, `Bytes/Second`, `Kilobytes/Second`,
    `Megabytes/Second`, `Gigabytes/Second`, `Terabytes/Second`, `Bits/Second`,
    `Kilobits/Second`, `Megabits/Second`, `Gigabits/Second`, `Terabits/Second`,
    `Count/Second`, `None`
  EOF
}

variable "extended_statistic" {
  type        = string
  nullable    = true
  default     = null
  description = <<EOF
    The percentile statistic for the alarm's associated metric. Specify a value
    between p0.0 and p100.
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

variable "tags" {
  type        = map(string)
  nullable    = false
  default     = {}
  description = "A mapping of tags to assign to the resource."
}
