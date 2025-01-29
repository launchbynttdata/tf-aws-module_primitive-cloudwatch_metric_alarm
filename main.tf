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

resource "aws_cloudwatch_metric_alarm" "metric_alarm" {
  alarm_name                = var.alarm_name
  comparison_operator       = var.comparison_operator
  evaluation_periods        = var.evaluation_periods
  metric_name               = var.metric_name
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = var.statistic
  threshold                 = var.threshold
  threshold_metric_id       = var.threshold_metric_id
  actions_enabled           = var.actions_enabled
  alarm_actions             = var.alarm_actions
  alarm_description         = var.alarm_description
  datapoints_to_alarm       = var.datapoints_to_alarm
  dimensions                = var.dimensions
  insufficient_data_actions = var.insufficient_data_actions
  ok_actions                = var.ok_actions
  unit                      = var.unit
  extended_statistic        = var.extended_statistic
  treat_missing_data        = var.treat_missing_data

  tags = local.tags

  dynamic "metric_query" {
    for_each = var.metric_query == null ? {} : var.metric_query

    content {
      id          = metric_query.key
      account_id  = metric_query.value.account_id
      label       = metric_query.value.label
      period      = metric_query.value.period
      expression  = metric_query.value.expression
      return_data = metric_query.value.return_data

      dynamic "metric" {
        for_each = metric_query.value.metric == null ? {} : { "metric" = metric_query.value.metric }

        content {
          metric_name = metric.value.metric_name
          namespace   = metric.value.namespace
          period      = metric.value.period
          stat        = metric.value.stat
          unit        = metric.value.unit
          dimensions  = metric.value.dimensions
        }
      }
    }
  }
}
