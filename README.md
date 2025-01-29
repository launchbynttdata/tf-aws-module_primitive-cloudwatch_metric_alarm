# tf-aws-module_primitive-cloudwatch_metric_alarm

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module provides a CloudWatch Metric Alarm resource used to trigger notifications or other actions when a metric breaches a threshold value.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.84.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.metric_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_name"></a> [alarm\_name](#input\_alarm\_name) | Descriptive name for an alarm. This name must be unique within the AWS account. | `string` | n/a | yes |
| <a name="input_comparison_operator"></a> [comparison\_operator](#input\_comparison\_operator) | The arithmetic operation to use when comparing the specified Statistic and<br/>    Threshold. Normal alarms support the following values: `GreaterThanOrEqualToThreshold`, `GreaterThanThreshold`,<br/>    `LessThanThreshold`, `LessThanOrEqualToThreshold`. Anomaly detection alarms support the<br/>    following additional values: `LessThanLowerOrGreaterThanUpperThreshold`, `LessThanLowerThreshold`,<br/>    and `GreaterThanUpperThreshold`. | `string` | n/a | yes |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | The number of periods over which data is compared to the specified<br/>    threshold. | `number` | `3` | no |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | The name for the metric associated with the alarm. For a list of<br/>    AWS services and the metrics they publish, see the documentation<br/>    here: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace for the alarm's associated metric. For a list of AWS<br/>    namespaces, see the documentation here: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html | `string` | `null` | no |
| <a name="input_period"></a> [period](#input\_period) | The period, in seconds, over which the specified Statistic is applied.<br/>    Valid values are 10, 30, and any multiple of 60. | `number` | `null` | no |
| <a name="input_statistic"></a> [statistic](#input\_statistic) | The statistic to apply to the alarm's associated metric. The value must be one of the following:<br/>    `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`. | `string` | `null` | no |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The value against which the specified statistic is compared. This parameter<br/>    is required for alarms based on static thresholds, but should not be used for<br/>    alarms based on anomaly detection models. | `number` | `null` | no |
| <a name="input_threshold_metric_id"></a> [threshold\_metric\_id](#input\_threshold\_metric\_id) | If this is an alarm based on an anomaly detection model, make this value<br/>    match the ID of the ANOMALY\_DETECTION\_BAND function. | `string` | `null` | no |
| <a name="input_actions_enabled"></a> [actions\_enabled](#input\_actions\_enabled) | Indicates whether or not actions should be executed during any changes to the alarm's state. | `bool` | `true` | no |
| <a name="input_alarm_actions"></a> [alarm\_actions](#input\_alarm\_actions) | The list of actions to execute when this alarm transitions into an ALARM state from any other state.<br/>    Each action is specified as an Amazon Resource Name (ARN). | `list(string)` | `[]` | no |
| <a name="input_alarm_description"></a> [alarm\_description](#input\_alarm\_description) | The description for the alarm. | `string` | `""` | no |
| <a name="input_datapoints_to_alarm"></a> [datapoints\_to\_alarm](#input\_datapoints\_to\_alarm) | The number of data points that must be breaching to trigger the alarm.<br/>    This is used only if you are setting an "M out of N" alarm. In that case,<br/>    this value is the M. For more information, see Evaluating an Alarm in the<br/>    Amazon CloudWatch User Guide. | `number` | `null` | no |
| <a name="input_dimensions"></a> [dimensions](#input\_dimensions) | The dimensions for the alarm's associated metric. For a list of AWS<br/>    services and the dimensions they publish, see the documentation here:<br/>    https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html | `map(string)` | `null` | no |
| <a name="input_insufficient_data_actions"></a> [insufficient\_data\_actions](#input\_insufficient\_data\_actions) | The list of actions to execute when this alarm transitions into an INSUFFICIENT\_DATA state from any other state.<br/>    Each action is specified as an Amazon Resource Name (ARN). | `list(string)` | `[]` | no |
| <a name="input_ok_actions"></a> [ok\_actions](#input\_ok\_actions) | The list of actions to execute when this alarm transitions into an OK state from any other state.<br/>    Each action is specified as an Amazon Resource Name (ARN). | `list(string)` | `[]` | no |
| <a name="input_unit"></a> [unit](#input\_unit) | The unit of the alarm's associated metric. Valid values: `Seconds`,<br/>    `Microseconds`, `Milliseconds`, `Bytes`, `Kilobytes`, `Megabytes`,<br/>    `Gigabytes`, `Terabytes`, `Bits`, `Kilobits`, `Megabits`, `Gigabits`,<br/>    `Terabits`, `Percent`, `Count`, `Bytes/Second`, `Kilobytes/Second`,<br/>    `Megabytes/Second`, `Gigabytes/Second`, `Terabytes/Second`, `Bits/Second`,<br/>    `Kilobits/Second`, `Megabits/Second`, `Gigabits/Second`, `Terabits/Second`,<br/>    `Count/Second`, `None` | `string` | `null` | no |
| <a name="input_extended_statistic"></a> [extended\_statistic](#input\_extended\_statistic) | The percentile statistic for the alarm's associated metric. Specify a value<br/>    between p0.0 and p100. | `string` | `null` | no |
| <a name="input_treat_missing_data"></a> [treat\_missing\_data](#input\_treat\_missing\_data) | Sets how this alarm is to handle missing data points. The following values are supported:<br/>    `missing`, `ignore`, `breaching`, `notBreaching`. The default value is `missing`. | `string` | `"missing"` | no |
| <a name="input_metric_query"></a> [metric\_query](#input\_metric\_query) | A map of objects that describes the metric queries associated with the alarm.<br/>    This is required if you are creating an alarm based on a metric math expression.<br/><br/>    If you specify a metric\_query, you may not specify a metric\_name, namespace, period, or<br/>    statistic on the same alarm. If you do not specify a metric query, you must specify each<br/>    of those fields.<br/><br/>    Within a metric query, you must specify either `metric` or `expression` but not both.<br/><br/>    The map's key will be used as the metric\_query's id. The id must be unique within the alarm.<br/>    If you are performing math expressions on this set of data, this name represents that data<br/>    and can serve as a variable in the mathematical expression. The valid characters are letters,<br/>    numbers, and underscore. The first character must be a lowercase letter.<br/><br/>    map(object({<br/>      account\_id  = (Optional) The ID of the account where the metrics are located, if this is a cross-account alarm.<br/>      label       = (Optional) A human-readable label for this metric or expression. This is especially useful if this is an expression, so that you know what the value represents.<br/>      period      = (Optional) Granularity in seconds of returned data points. For metrics with regular resolution, valid values are any multiple of 60. For high-resolution metrics, valid values are 1, 5, 10, 30, or any multiple of 60.<br/>      expression  = (Optional) The math expression to be performed on the returned data, if this object is performing a math expression. This expression can use the id of the other metrics to refer to those metrics, and can also use the id of other expressions to use the result of those expressions. For more information about metric math expressions, see https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html#metric-math-syntax.<br/>      metric      = optional(object({<br/>        metric\_name = (Required) The name for this metric.<br/>        namespace   = (Required) The namespace for this metric.<br/>        period      = (Required) Granularity in seconds of returned data points. For metrics with regular resolution, valid values are any multiple of 60. For high-resolution metrics, valid values are 1, 5, 10, 30, or any multiple of 60.<br/>        stat        = (Required) The statistic to apply to this metric. Refer to the description of the top-level `statistic` variable in this module for valid values.<br/>        unit        = (Optional) The unit for this metric. Refer to the description of the top-level `unit` variable in this module for valid values.<br/>        dimensions  = (Optional) The dimensions for this metric.<br/>      }))<br/>      return\_data = (Optional) Specify exactly one metric\_query to be true to use that metric\_query result as the alarm.<br/>    })) | <pre>map(object({<br/>    account_id = optional(string)<br/>    expression = optional(string)<br/>    label      = optional(string)<br/>    period     = optional(number)<br/>    metric = optional(object({<br/>      metric_name = string<br/>      namespace   = string<br/>      period      = number<br/>      stat        = string<br/>      unit        = optional(string)<br/>      dimensions  = optional(map(string))<br/>    }))<br/>    return_data = optional(bool, false)<br/>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_alarm_name"></a> [alarm\_name](#output\_alarm\_name) | n/a |
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
